#====EXPLORATORY TEXT ANALYSIS====

#==== BASIC STATS ====

votos_unnested<-read_xlsx("votos_tokens.xlsx")

#Vocabulary
votos_unnested_count<-votos_unnested %>%
                      count(word) %>% 
                      mutate(word=reorder(word,n))

summary(votos_unnested_count$n)

quantile(votos_unnested_count$n,probs = .65)

#Words per document

words_ap<-votos_unnested %>% 
  group_by(n_ap) %>% 
  summarize(count=n())

summary(words_ap$count)
sd(words_ap$count)

boxplot(words_ap$count)

#Additional stats

votos_counter <-votos_unnested %>%
  count(n_ap, word, name = "n")


term_stats <- votos_counter %>%
  group_by(word) %>%
  summarise(
    tf = sum(n),                 
    df = n_distinct(n_ap),      
    .groups = "drop"
  )

summary(term_stats$tf)
summary(term_stats$df)
quantile(term_stats$tf, probs = c(.50,.75,.90,.95,.99))
quantile(term_stats$df, probs = c(.50,.75,.90,.95,.99))

# token percentage above a certain term-frequency
coverage_tbl <- term_stats %>%
  arrange(desc(tf)) %>%
  mutate(tokens_acum = cumsum(tf),
         rank = row_number()) %>%
  transmute(rank, tf, tokens_acum)

N <- 1000

coverage_tbl %>% slice(N) %>% mutate(pct = tokens_acum / sum(term_stats$tf))



#====GRAPHICAL ANALYSIS ====

#TOP-20 MOST FREQUENT WORDS
library(ggplot2)
votos_unnested %>% 
  count(word,sort = TRUE) %>% 
  mutate(word=reorder(word,n)) %>% 
  slice_head(n=20) %>% 
  ggplot()+
  geom_col(aes(x=n,y=word), fill="dodgerblue2")+
  labs(y="Palavra",
       x="n",
       title = "Palavras mais mencionadas")+
  theme(text = element_text(size = 12))+
  theme_classic()



#WORDCLOUD 
library(wordcloud)
library(webshot)
library(htmlwidgets)


#dataset 
data_wordcloud<-votos_unnested %>% 
  count(word) %>% 
  mutate(word=reorder(word,n))  

#color vector
colorVec2 = rep(c('lightskyblue1','deepskyblue2','dodgerblue4'), length.out=nrow(data_wordcloud))

x11()
set.seed(123) 
wordcloud(words = data_wordcloud$word, freq = data_wordcloud$n, 
          min.freq = 1,
          scale=c(5,0.5),     # Set min and max scale
          max.words=300,
          random.order=FALSE, # Words in decreasing freq
          rot.per=0.35,# % of vertical words
          use.r.layout=TRUE, # Use C++ collision detection
          colors=colorVec2)




#TF-IDF ANALYSIS

#Complete dataset

votos_counter<-votos_counter %>%
  bind_tf_idf(word, n_ap, n)

votos_counter %>%
  arrange(desc(tf_idf)) %>% 
  slice_max(order_by = tf_idf, n = 10) %>%  # top 20 geral
  mutate(word = reorder(word, tf_idf)) %>%  # ordena para o gráfico
  ggplot(aes(x = word, y = tf_idf, fill = tf_idf)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(x = "Palavra", y = "TF-IDF") +
  theme_minimal()


# Splitting the dataset according to the rapporteur's classification
# and replotting the TF-IDF graphs:
# "serious crimes" and "less serious crimes"


crimesgraves_ids <- c("1057","1058","1060","1066","1071","1075","1077",
                      "1109","1112","1113","1116","1123","1125","1130","1133","1147",
                      "1153","1156","1163","1173","1176","1177","1178",
                      "1179","1180","1183","1184","1190","1268","1269",
                      "1380","1381","1388","1391","1403","1405","1413",
                      "1416","1419","1421","1422","1427","1429","1432",
                      "1488","1492","1498","1499","1502","1503","1512",
                      "1517","1545","2330","2337","2442","2540","1629",
                      "1735","2150","2327","2447","2497","2507","2508","2520")

# votos_counter deve ter colunas: n_ap (doc), word (termo), n (contagem no doc)
crimesgraves_sub <- votos_counter %>% 
  filter(n_ap %in% crimesgraves_ids)

# 1) Calcula tf-idf por (doc, termo) dentro do subconjunto
crimesgraves_tfidf_doc <- crimesgraves_sub %>%
  bind_tf_idf(term = word, document = n_ap, n = n)

# 2) Agrega para ter um único tf-idf por palavra no corpus de crimes graves:
#    soma os tf (n) entre docs e mantém o idf (é o mesmo por palavra em todos os docs)
crimesgraves_tfidf_global <- crimesgraves_tfidf_doc %>%
  group_by(word) %>%
  summarise(
    tf = sum(n),
    idf = first(idf),
    tf_idf = tf * idf,
    .groups = "drop"
  ) %>%
  arrange(desc(tf_idf))

# (opcional) pegar top-N para plot
topN <- 15
crimesgraves_top <- crimesgraves_tfidf_global %>% slice_head(n = topN)

# Gráfico único (sem facets), ranking global
ggplot(crimesgraves_top, aes(x = reorder(word, tf_idf), y = tf_idf)) +
  geom_col(fill="dodgerblue3") +
  coord_flip() +
  labs(x = "Palavra", y = "TF-IDF",
       title = paste("Top", topN, "palavras por TF-IDF (Crimes graves)")) +
  theme_minimal()




crimesleves_ids<-c("1105", "1193", "1194", "1228", "1250", "1285", "1296", 
                   "1314", "1359", "1373", "1423", "1473", "1550", "1575", "1670", 
                   "1702", "1740", "1743", "1764", "1773", "1780", "2085",
                   "2087", "2326", "2468", "2472", "1096", "1103", "1224", 
                   "1337", "1464", "1468", "1521", "1548", "1573", "1642", 
                   "1666", "1705", "1786", "1789", "1792", "1818", "1842", 
                   "1857", "1858", "1935", "1960", "1970", "1972", "2006", 
                   "2015", "2023", "2057", "2061", "2080", "2111", "2130", 
                   "2137", "2139", "2144", "2148", "2157", "2162", "2174", 
                   "2175", "2187", "2219", "2245", "2276", "2285", "2287", 
                   "2315", "2320", "2373", "2376", "2387", "2471", "2476", 
                   "2529", "2536", "2547", "2548", "2562")

# votos_counter deve ter colunas: n_ap (doc), word (termo), n (contagem no doc)
crimesleves_sub <- votos_counter %>% 
  filter(n_ap %in% crimesleves_ids)

# 1) Calcula tf-idf por (doc, termo) dentro do subconjunto
crimesleves_tfidf_doc <- crimesleves_sub %>%
  bind_tf_idf(term = word, document = n_ap, n = n)

# 2) Agrega para ter um único tf-idf por palavra no corpus de crimes graves:
#    soma os tf (n) entre docs e mantém o idf (é o mesmo por palavra em todos os docs)
crimesleves_tfidf_global <- crimesleves_tfidf_doc %>%
  group_by(word) %>%
  summarise(
    tf = sum(n),
    idf = first(idf),
    tf_idf = tf * idf,
    .groups = "drop"
  ) %>%
  arrange(desc(tf_idf))

# (opcional) pegar top-N para plot
topN <- 15
crimesleves_top <- crimesleves_tfidf_global %>% slice_head(n = topN)

# Gráfico único (sem facets), ranking global
ggplot(crimesleves_top, aes(x = reorder(word, tf_idf), y = tf_idf)) +
  geom_col(fill="dodgerblue3") +
  coord_flip() +
  labs(x = "Palavra", y = "TF-IDF",
       title = paste("Top", topN, "palavras por TF-IDF (Crimes leves)")) +
  theme_minimal()




