#==== METADATA ANALYSIS ====

library(tidyverse)
library(tm)
library(textclean)
library(stopwords)
library(stringi)
library(stringr)
library(readxl)
library(tidytext)

metadados<-read_xlsx("metadata.xlsx")

metadados$data_acordao<-as.character(metadados$data_acordao)

#====General Stats====
crimesgraves<-metadados %>%
  filter(privacao_liberdade == 1)

print(crimesgraves$n_ap)

crimesleves<-metadados %>%
  filter(privacao_liberdade == 0)  

print(crimesleves$n_ap)

summary(metadados$tempo_pena)
boxplot(metadados$tempo_pena)

table(metadados$sexo)
table(metadados$orgao)
table(metadados$divergencia)
table(metadados$tempo_pena)


ggplot(metadados, aes(x = tempo_pena, 
                      y = n_pag_voto_relator,
                      color = factor(privacao_liberdade))) +
  geom_point(size = 3, alpha = 0.7) +
  scale_color_manual(
    values = c("0" = "lightskyblue1", "1" = "dodgerblue4"),
    labels = c("0" = "não", "1" = "sim")
  ) +
  labs(
    x = "Tempo da pena (em meses)",
    y = "Número de páginas do voto do relator",
    color = "Privação de liberdade"
  ) +
  theme_minimal(base_size = 13)


ggplot(metadados, aes(x = factor(privacao_liberdade),
                      y = tempo_pena,
                      fill = factor(privacao_liberdade))) +
  geom_boxplot(alpha = 0.7, outlier.color = "black") +
  scale_fill_manual(
    values = c("0" = "lightskyblue1", "1" = "dodgerblue4"),
    labels = c("não", "sim")
  ) +
  scale_x_discrete(
    labels = c("0" = "não", "1" = "sim")
  ) +
  scale_y_continuous(
    breaks = seq(0, max(metadados$tempo_pena, na.rm = TRUE), by = 12)
  ) +
  labs(
    x = "Privação de liberdade",
    y = "Tempo de pena (meses)",
    fill = "Privação de liberdade"
  ) +
  theme_minimal(base_size = 13)


table(metadados$privacao_liberdade)
table(metadados$data_acordao)

#====Size of opinions per decision====

proporção_voto<-tibble((metadados$n_pag_voto_relator/metadados$n_pag)*100)
names(proporção_voto)<-c("proporcao")

summary(proporção_voto)


ggplot(metadados, aes(x = n_pag, y = n_pag_voto_relator)) +
  geom_point(aes(fill = factor(privacao_liberdade)), 
             shape = 21, color = "black", size = 2) +
  scale_fill_manual(values = c("0" = "dodgerblue4", "1" = "lightskyblue1")) +
  labs(fill = "Privação de Liberdade") +
  theme_minimal() +
  theme(
    # Linhas dos eixos X e Y
    axis.line.x = element_line(color = "black", linewidth = 1),
    axis.line.y = element_line(color = "black", linewidth = 1),
    
    # Maior destaque nas linhas de grade (opcional)
    panel.grid.major = element_line(color = "gray80", linewidth = 0.5),
    panel.grid.minor = element_line(color = "gray90", linewidth = 0.5))



#===Type of Conviction Per Gender====

prop.table(with(metadados, table(sexo, privacao_liberdade)), margin = 1)


metadados$privacao_liberdade <- factor(
  metadados$privacao_liberdade,
  levels = c(0, 1),
  labels = c("Não", "Sim")
)

#Gráfico com a proporção de condenados por sexo e tipo de pena

ggplot(metadados, aes(x = sexo, fill = privacao_liberdade)) +
  geom_bar(position = "fill") +
  labs(
    y = "Proporção",
    fill = "Privação de liberdade"
  ) +
  scale_y_continuous(labels = scales::percent) +
  coord_flip()


ggplot(metadados, aes(x = sexo, fill = privacao_liberdade)) +
  geom_bar(position = "fill") +
  labs(
    y = "Proporção",
    fill = "Privação de liberdade"
  ) +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(
    values = c("Não" = "#A6CEE3", "Sim" = "#1F78B4")  # azul claro e azul escuro
  ) +
  coord_flip() +
  theme_minimal(base_size = 13)




#==== REANALYZING METADATA AFTER TOPIC ASSIGNMENT ====


topic_doc_v1<-read_xlsx("topicdoc_Thetamatrix.xlsx")

metadados <- metadados %>%
  mutate(n_ap = as.character(n_ap))

metadados_completo<-metadados %>%
  left_join(topic_doc_v1, by = "n_ap")


metadados_completo %>%
  filter(topico %in% c(4, 5, 6)) %>%
  select(n_ap, topico) %>%
  arrange(topico, n_ap)

#==== SENTENCE DURATION BY TOPIC ====

metadados_completo<-metadados_completo %>%
  mutate(topico = factor(topico))


tons_azuis <- c(
  "1" = "#c6dbef",  # azul muito claro
  "2" = "#9ecae1",
  "3" = "#6baed6",
  "4" = "#4292c6",
  "5" = "#2171b5",
  "6" = "#084594"   # azul escuro
)

# gráfico de dispersão
ggplot(metadados_completo, aes(x = topico, y = tempo_pena, color = topico)) +
  geom_jitter(width = 0.2, alpha = 0.8, size = 3) +
  scale_color_manual(values = tons_azuis, name = "Tópico") +
  labs(
    x = "Tópico",
    y = "Tempo de pena (meses)"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position = "right",    # legenda visível à direita
    legend.title = element_text(size = 13, face = "bold"),
    legend.text = element_text(size = 12)
  )


#==== GENDER AND TOPIC ====
metadados_completo<-metadados_completo %>%
  mutate(sexo = factor(sexo))

# gráfico de barras
ggplot(metadados_completo, aes(x = topico, fill = topico)) +
  geom_bar(position = "dodge", alpha = 0.9) +
  facet_wrap(~sexo, ncol = 1, scales = "free_y") +  # uma linha por sexo
  scale_fill_manual(values = tons_azuis, name = "Tópico") +
  labs(
    x = "Tópico",
    y = "Número de casos",
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.title = element_text(size = 13, face = "bold"),
    legend.text = element_text(size = 12),
    strip.text = element_text(size = 13, face = "bold")
  )


#numeto de páginas x topicos

ggplot(metadados_completo, aes(x = n_pag, y = n_pag_voto_relator, fill = topico)) +
  geom_point(shape = 21, size = 3.5, color = "grey30", alpha = 0.85) +
  scale_fill_manual(values = tons_azuis, name = "Tópico") +
  labs(
    x = "Páginas do Acórdão",
    y = "Páginas do Voto do Relator",
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "right",
    legend.title = element_text(face = "bold")
  )

#==== REANALYZING TEXT DATA ====


votos_unnested<-read_xlsx("votos_tokens.xlsx")
votos_counter <-votos_unnested %>%
  count(n_ap, word, name = "n")  

votos_counter <- votos_counter %>% mutate(n_ap = as.character(n_ap))
topic_doc_v1  <- topic_doc_v1  %>% mutate(n_ap = as.character(n_ap))

# Attributes a topic to each word (via n_ap) and aggregates by topic-word
vocab_por_topico <- votos_counter %>%
  inner_join(topic_doc_v1 %>% select(n_ap, topico), by = "n_ap") %>%
  group_by(topico, word) %>%
  summarise(n = sum(n), .groups = "drop")

summary(vocab_por_topico)

# calculate the 0.8 quantile of n per topic
limiares <- vocab_por_topico %>%
  group_by(topico) %>%
  summarise(q80 = quantile(n, 0.8))


vocab_top80 <- vocab_por_topico %>%
  inner_join(limiares, by = "topico") %>%
  filter(n >= q80)

# Counting words > q80
contagem_top80 <- vocab_top80 %>%
  count(topico, name = "num_palavras")

contagem_top80

# Adding values manually
contagem_top80$num_palavras <- c(837, 753, 1121, 224, 650, 338)

ggplot(contagem_top80, aes(x = factor(topico), y = num_palavras)) +
  geom_col(fill = "dodgerblue3", color = "grey20", alpha = 0.9, width = 0.7) +
  geom_text(
    aes(label = num_palavras),
    vjust = -0.5,           # posição acima da barra
    size = 4.5,
    fontface = "bold",
    color = "grey20"
  ) +
  labs(
    x = "Tópico",
    y = "Número de palavras (≥ quantil 0.8)"
  ) +
  theme_minimal(base_size = 14)



