#==== TOPIC MODELING ====

#==== Document-Term Matrix====

library(Matrix)

votos_unnested<-read_xlsx("votos_tokens.xlsx")

votos_counter <-votos_unnested %>%
  count(n_ap, word, name = "n")        


dtm<-votos_counter %>%
  cast_dtm(document = n_ap, term = word, value = n)
dtm


#====MODEL SELECTION ====


library(topicmodels)
library(ldatuning)


#==== Testing for optimal k ====
#====Ldatuning (Discarded) =====

tuning_results <- FindTopicsNumber(
  dtm,
  topics = seq(2, 14, by = 1),
  metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
  method = "Gibbs",
  control = list(seed = 123, alpha = 0.1),
  mc.cores = 4L,
  verbose = TRUE
)



# Find optimal K (example: using Arun2010 minimum)

encontrar_otimos <- function(tuning_results) {
  otimos <- list()
  
  # Griffiths2004 - MAIOR valor é melhor
  otimos$Griffiths2004 <- tuning_results$topics[which.max(tuning_results$Griffiths2004)]
  
  # CaoJuan2009 - MENOR valor é melhor  
  otimos$CaoJuan2009 <- tuning_results$topics[which.min(tuning_results$CaoJuan2009)]
  
  # Arun2010 - MENOR valor é melhor (você já fez esse)
  otimos$Arun2010 <-tuning_results$topics[which.min(tuning_results$Arun2010)]
  
  # Deveaud2014 - MAIOR valor é melhor
  otimos$Deveaud2014 <- tuning_results$topics[which.max(tuning_results$Deveaud2014)]
  
  return(otimos)
}


valores_otimos <- encontrar_otimos(tuning_results)
print(valores_otimos)

# Usando o objeto correto: tuning_results
result_long <- tuning_results %>%
  pivot_longer(
    cols = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
    names_to = "Metrica",
    values_to = "Valor"
  )

# Gráfico básico
ggplot(result_long, aes(x = topics, y = Valor, color = Metrica)) +
  geom_line() +
  geom_point() +
  facet_wrap(~Metrica, scales = "free_y") +
  labs(
    title = "Métricas de Tuning LDA",
    x = "Número de Tópicos",
    y = "Valor da Métrica"
  ) +
  theme_minimal()


#==== MANUAL SELECTION ====

# The value of k was determined by evaluating LDA models with
# values ranging from 2 to 14 using coherence, exclusivity,
# and perplexity metrics. The final model uses k = 6.

lda_gibbs<-LDA(x = dtm,
               k=6,
               method = "Gibbs",
               control = list(
                 # priore da distribuição dos topicos sob os documentos
                 # default = 0.1  
                 alpha = 0.16,
                 #parameter specifies the parameter of the prior distribution of the term distribution over topics - BETA
                 # default = 0.1
                 delta = 0.0001,
                 # nº de iterações 
                 # default = 2000
                 iter = 2000,
                 #semente aleatória
                 seed=123))


#==== Beta Matrix====
# Words associated with each topic
terms(lda_gibbs, k = 6)

# Term-topic probabilities - β ("beta") matrix
lda_v1_result<-tidy(lda_gibbs,matrix="beta")

writexl::write_xlsx(lda_v1_result, path="termotopic_Betamatrix.xlsx", col_names=T)

#=== Top 10 words per topic ====
x11()
lda_v1_result %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta) %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot() +
  aes(x = beta, y = term, fill = factor(topic)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  scale_y_reordered() +
  labs(title = "Probabilidades por tópico por palavras")


#====Theta Matrix and Dominant Topic ====

theta<-posterior(lda_gibbs)$topics

# Cria dataframe no qual é atribuído o tópico mais frequente para cada registro
topic_doc_v1<-as.data.frame(topics(lda_gibbs)) %>% #pega os tópicos 
  rownames_to_column(var = "n_ap")%>% #pega o número do registro
  set_names(c("n_ap", "topico")) #renomeia colunas

#rótulos atribuídos aos tópicos
rotulos_topicos <- tibble(
  topico = 1:6,
  rotulo = c(
    "Contexto fático crimes graves",
    "Contexto fático crimes leves",
    "Forma de execução dos crimes e cicunstâncias individuais",
    "Processo e garantias processuais",
    "Penas e suas dosimetrias",
    "Crimes cometidos e bens jurídicos lesados"
  )
)

topic_doc_v1<-topic_doc_v1%>%
  left_join(rotulos_topicos, by= "topico")


#guardando esse resultado
writexl::write_xlsx(topic_doc_v1, path= "topicdoc_Thetamatrix.xlsx", col_names=T)



#Verificando frequência dos tópicos no corpus
topic_doc_v1 %>% 
  ggplot()+
  geom_bar(aes(Topico), fill="dodgerblue3")


topic_doc_v1 %>% 
  mutate(topico = factor(topico)) %>% 
  ggplot(aes(x = topico)) +
  geom_bar(fill = "dodgerblue3") +
  labs(
    x = "Tópico",
    y = "Número de documentos",
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.text.x = element_text(angle = 0, hjust = 0.5)
  )

  
#==== MODEL EVALUATION METRICS ====  
  
#====Perplexity====

library(slam)
topicmodels::perplexity(lda_gibbs, newdata = dtm)


#===Coeherence ====

library(text2vec)
top_n <- 20 
x<-terms(lda_gibbs, top_n)

dtm_bin <- sign(dtm)
tcm_intr <- crossprod(dtm_bin)   # coocorrência termo-termo


coh_intr <- coherence(x, tcm_intr, metrics = c("mean_npmi"),
                      n_doc_tcm = nrow(dtm_bin))
coh_intr

#====Exclusivity ====


topicdoc::topic_exclusivity(lda_gibbs, top_n_tokens = 10)


#====GRAPHS ====

#PERPLEXITY
perplexidade<-read_excel("metricsbyk.xlsx", sheet = "perplexidade")

ggplot(perplexidade, aes(x = k, y = perplexidade)) +
  geom_line(color = "deepskyblue4", linewidth = 1) +     # linha azul clara
  geom_point(size = 2.5, color = "deepskyblue4") +       # pontos azul claro
  scale_y_continuous(
    breaks = seq(1105, 1155, 5),
    limits = c(1105, 1155)                              # remova se houver pontos fora
  ) +
  scale_x_continuous(breaks = sort(unique(perplexidade$k))) +
  labs(
    x = "k (número de tópicos)",
    y = "Perplexidade"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.title = element_text(face = "bold")
  )

#COHERENCE
coerencia<-read_excel("metricsbyk.xlsx", sheet = "coerência")

#OPTION 1

coerencia_summary <- coerencia %>%
  group_by(k) %>%
  summarise(media = mean(npmi, na.rm = TRUE),
            sd = sd(npmi, na.rm = TRUE),
            .groups = "drop")

ggplot(coerencia_summary, aes(x = k, y = media)) +
  geom_line(color = "dodgerblue4", linewidth = 1.2) +
  geom_point(size = 3, color = "lightskyblue1") +
  geom_errorbar(aes(ymin = media - sd, ymax = media + sd),
                width = 0.2, color = "gray30") +
  scale_y_continuous(limits = c(-1, 1), breaks = seq(-1, 1, 0.2)) +
  labs(x = "Número de tópicos (k)",
       y = "Coerência média (NPMI)") +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(face = "bold"))



#OPTION 2

install.packages("ggridges")
library(ggridges)

ggplot(coerencia, aes(x = npmi, y = factor(k), fill = factor(k))) +
  geom_density_ridges(alpha = 0.8, color = "black") +
  scale_fill_viridis_d(option = "viridis") +
  scale_x_continuous(limits = c(-1, 1)) +
  labs(x = "Coerência (NPMI)", y = "Número de tópicos (k)") +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(face = "bold"),
        legend.position = "none")

#EXCLSUIVITY

exclusividade<-read_excel("metricsbyk.xlsx", sheet = "exclusividade")

max(exclusividade$exclusividade)

library(RColorBrewer)

ggplot(exclusividade, aes(x = factor(k), y = exclusividade, fill = factor(k))) +
  geom_boxplot(outlier.alpha = 0.5, color = "black") +
  scale_fill_viridis_d(option = "viridis", direction = 1, name = "k") +
  geom_jitter(width = 0.15, alpha = 0.6, size = 1.8, color = "black") +
  labs(x = "k (número de tópicos)",
       y = "Exclusividade") +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(face = "bold"),
        legend.position = "none")


# Pacotes
library(readxl)
library(dplyr)
library(ggplot2)
install.packages("viridisLite"); library(viridisLite)

# 1) Ler a aba "exclusividade"
df <- read_excel("metricsbyk.xlsx", sheet = "exclusividade")


# 2) Gráfico de dispersão

ggplot(df, aes(x = npmi, y = exclusividade, color = factor(k))) +
  geom_point(size = 2.4, alpha = 0.9) +
  # camada extra: circula apenas k = 6
  geom_point(
    data = df %>% filter(k == 6),
    aes(x = npmi, y = exclusividade),
    inherit.aes = FALSE,
    shape = 21, fill = NA, color = "black", size = 4.2, stroke = 1.1
  ) +
  labs(
    title = "Exclusividade × Coerência (NPMI)",
    x = "Coerência(NPMI)",
    y = "Exclusividade",
    color = "k (nº de tópicos)"
  ) +
  scale_color_viridis_d(option = "C") +
  theme_minimal(base_size = 13) +
  theme(legend.position = "right")


#====WORDCLOUDS PER TOPIC ====


library(wordcloud)


topic_terms<-read_xlsx("termotopic_Betamatrix.xlsx")

#Topic 1
df_t1 <- topic_terms %>%
  filter(topic == 1) %>%
  arrange(desc(beta))

#Paletas de cores para wordcloud
colorVec2 = rep(c('lightskyblue1','deepskyblue2','dodgerblue4'), length.out=nrow(df_t1))

set.seed(123) 
x11()
wordcloud(words = df_t1$term, 
          freq = df_t1$beta, 
          min.freq = 1,
          scale = c(4, 0.8),     # Set min and max scale
          max.words=150,
          random.order=FALSE, # Words in decreasing freq
          rot.per     = 0.35,
          use.r.layout=TRUE, # Use C++ collision detection
          colors=colorVec2)


#Topic 2


df_t2 <- topic_terms %>%
  filter(topic == 2) %>%
  arrange(desc(beta))

#Paletas de cores para wordcloud
colorVec2 = rep(c('lightskyblue1','deepskyblue2','dodgerblue4'), length.out=nrow(df_t2))

set.seed(123) 
x11()
wordcloud(words = df_t2$term, 
          freq = df_t2$beta, 
          min.freq = 1,
          scale = c(4, 0.8),     # Set min and max scale
          max.words=150,
          random.order=FALSE, # Words in decreasing freq
          rot.per     = 0.35,
          use.r.layout=TRUE, # Use C++ collision detection
          colors=colorVec2)

#Topic 3


df_t3 <- topic_terms %>%
  filter(topic == 3) %>%
  arrange(desc(beta))

#Paletas de cores para wordcloud
colorVec2 = rep(c('lightskyblue1','deepskyblue2','dodgerblue4'), length.out=nrow(df_t3))

set.seed(123) 
x11()
wordcloud(words = df_t3$term, 
          freq = df_t3$beta, 
          min.freq = 1,
          scale = c(4, 0.8),     # Set min and max scale
          max.words=150,
          random.order=FALSE, # Words in decreasing freq
          rot.per     = 0.35,
          use.r.layout=TRUE, # Use C++ collision detection
          colors=colorVec2)



#Topic 4

df_t4 <- topic_terms %>%
  filter(topic == 4) %>%
  arrange(desc(beta))

#Paletas de cores para wordcloud
colorVec2 = rep(c('lightskyblue1','deepskyblue2','dodgerblue4'), length.out=nrow(df_t4))

set.seed(123) 
x11()
wordcloud(words = df_t4$term, 
          freq = df_t4$beta, 
          min.freq = 1,
          scale = c(4, 0.8),     # Set min and max scale
          max.words=150,
          random.order=FALSE, # Words in decreasing freq
          rot.per     = 0.35,
          use.r.layout=TRUE, # Use C++ collision detection
          colors=colorVec2)





#Topic 5


df_t5 <- topic_terms %>%
  filter(topic == 5) %>%
  arrange(desc(beta))

#Paletas de cores para wordcloud
colorVec2 = rep(c('lightskyblue1','deepskyblue2','dodgerblue4'), length.out=nrow(df_t5))

set.seed(123) 
x11()
wordcloud(words = df_t5$term, 
          freq = df_t5$beta, 
          min.freq = 1,
          scale = c(4, 0.8),     # Set min and max scale
          max.words=150,
          random.order=FALSE, # Words in decreasing freq
          rot.per     = 0.35,
          use.r.layout=TRUE, # Use C++ collision detection
          colors=colorVec2)




#Topic 6


df_t6 <- topic_terms %>%
  filter(topic == 6) %>%
  arrange(desc(beta))

#Paletas de cores para wordcloud
colorVec2 = rep(c('lightskyblue1','deepskyblue2','dodgerblue4'), length.out=nrow(df_t6))

set.seed(123) 
x11()
wordcloud(words = df_t6$term, 
          freq = df_t6$beta, 
          min.freq = 1,
          scale = c(4, 0.8),     # Set min and max scale
          max.words=150,
          random.order=FALSE, # Words in decreasing freq
          rot.per     = 0.35,
          use.r.layout=TRUE, # Use C++ collision detection
          colors=colorVec2)



