#==== PRE-PROCESSING ====

#Libraries
library(dplyr)
library(stringr)
library(tidyr)
library(writexl)
library(purrr)

#==== MAIN DATASET ====

#Creating the dataset containing the serial number and the original text from
#the rapporteur's opinions

n_ap<-c(1057, 1058, 1060, 1066, 1071, 1075, 1077, 1105, 1109, 
        1112, 1113, 1116, 1123, 1125, 1130, 1133, 1147, 1153, 1156,
        1163, 1173, 1176, 1177, 1178, 1179, 1180, 1183, 1184, 1190, 
        1193, 1194, 1228, 1250, 1268, 1269, 1285, 1296, 1314, 1359, 
        1373, 1380, 1381, 1388, 1391, 1403, 1405, 1413, 1416, 1419, 
        1421, 1422, 1423, 1427, 1429, 1432, 1473, 1488, 1492, 1498, 
        1499, 1502, 1503, 1512,1517, 1545, 1550, 1575, 1670, 1702, 
        1740, 1743, 1764, 1773, 1780, 2085, 2087, 2326, 2330, 2337,
        1096, 1103, 1224, 1337, 1464, 1468, 1521, 1548, 1573, 1629,
        1642, 1666, 1705, 1735, 1786, 1789, 1792, 1818, 1842, 1857,
        1858, 1935, 1960, 1970, 1972, 2006, 2015, 2023, 2057, 2061,
        2080, 2111, 2130, 2137, 2139, 2144, 2148, 2150, 2157, 2162,
        2174, 2175, 2187, 2219, 2245, 2276, 2285, 2287, 2315, 2320, 
        2327, 2373, 2376, 2387)

numeros_votos<-c(1057, 1058, 1060, 1066, 1071, 1075, 1077, 1105, 1109, 
                 1112, 1113, 1116, 1123, 1125, 1130, 1133, 1147, 1153, 1156,
                 1163, 1173, 1176, 1177, 1178, 1179, 1180, 1183, 1184, 1190, 
                 1193, 1194, 1228, 1250, 1268, 1269, 1285, 1296, 1314, 1359, 
                 1373, 1380, 1381, 1388, 1391, 1403, 1405, 1413, 1416, 1419, 
                 1421, 1422, 1423, 1427, 1429, 1432, 1473, 1488, 1492, 1498, 
                 1499, 1502, 1503, 1512,1517, 1545, 1550, 1575, 1670, 1702, 
                 1740, 1743, 1764, 1773, 1780, 2085, 2087, 2326, 2330, 2337,
                 1096, 1103, 1224, 1337, 1464, 1468, 1521, 1548, 1573, 1629,
                 1642, 1666, 1705, 1735, 1786, 1789, 1792, 1818, 1842, 1857,
                 1858, 1935, 1960, 1970, 1972, 2006, 2015, 2023, 2057, 2061,
                 2080, 2111, 2130, 2137, 2139, 2144, 2148, 2150, 2157, 2162,
                 2174, 2175, 2187, 2219, 2245, 2276, 2285, 2287, 2315, 2320, 
                 2327, 2373, 2376, 2387)


arquivos <- paste0("voto", numeros_votos, "_extraido.txt")

voto<-map_chr(arquivos, read_file)

#==== Main Data-frame====
votos<-data.frame(n_ap, votos)


#Creating an external file to store the dataset
votos_excel <- votos %>%
  mutate(votos = str_extract_all(votos, "(?s).{1,32000}")) %>%
  unnest_longer(votos) %>%
  group_by(n_ap) %>%
  mutate(parte = row_number()) %>%
  ungroup()

write_xlsx(votos_excel, "votos_excel.xlsx")


#==== FORMATING AND CHARCTER REMOVAL====

  
votos$voto <- gsub("Inteiro Teor do Ac[óo]rd[aã]o - Página \\d+ de \\d+", "", votos$voto)
votos$voto <- gsub("Documento assinado digitalmente conforme MP.*?senha [A-Z0-9\\-]+", "", votos$voto)
votos$voto <- gsub("-{2,}\\s*Página seguinte\\s*-{2,}", "", votos$voto)

# Remove os dois URLs específicos, se solicitado

votos$voto <- gsub("https://ultimosegundo\\.ig\\.com\\.br/politica/2023-01-17/violentamente-agredidos-pms-feridos-ataque-df\\.html", "", votos$voto)
votos$voto <- gsub("https://g1\\.globo\\.com/df/distrito-federal/noticia/2023/01/08/video-policial-da-cavalaria-e-agredido-por-bolsonaristas-no-df\\.ghtml", "", votos$voto)


# Remove quebras de linha
votos$voto <- gsub("\n+", " ", votos$voto)

# Remove pontuação e números
votos$voto <- gsub("[[:punct:]]", " ", votos$voto)
votos$voto <- gsub("[[:digit:]]", " ", votos$voto)

# Remove múltiplos espaços
votos$voto <- gsub("\\s+", " ", votos$voto)

# Transforma para minúsculas
votos$voto <- tolower(votos$voto)

#==== BIGRAMS AND TRIGRAMS====
#termos chave para posterior tokemização

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bestado\\s+democr[aá]tico\\s+de\\s+direito\\b",
                              "estado_democrático_direito")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bassocia[cç][aã]o\\s+criminosa\\b",
                              "associação_criminosa")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bcrimes?\\s+multitudin[áa]rios?\\b",
                              "crimes_multitudinários")


votos$voto <- str_replace_all(votos$voto,"(?iu)\\batos?\\s+antidemocr[aá]ticos?\\b",
                              "atos_antidemocráticos")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\baboli[cç][aã]o\\s+violenta\\b",
                              "abolição_violenta")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bacordo\\s+de\\s+n[aã]o\\s+persecu[cç][aã]o\\b",
                              "acordo_não_persecução")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bconcurso\\s+de\\s+pessoas\\b",
                              "concurso_pessoas")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bconcurso\\s+material\\b",
                              "concurso_material")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bdano\\s+qualificado\\b",
                              "dano_qualificado")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bdanos?\\s+morais\\s+coletivos\\b",
                              "danos_morais_coletivos")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bdeteriora[cç][aã]o\\s+do\\s+patrim[oô]nio\\b",
                              "deterioração_patrimônio")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bgolpe\\s+de\\s+estado\\b",
                              "golpe_estado")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bincita[cç][aã]o\\s+ao\\s+crime\\b",
                              "incitação_crime")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bfor[cç]as\\s+armadas\\b",
                              "forças_armadas")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bpoderes\\s+constitucionais\\b",
                              "poderes_constitucionais")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\bquartel\\s+general\\b",
                              "quartel_general")

votos$voto <- str_replace_all(votos$voto,"(?iu)\\btr[eé]s\\s+poderes\\b",
                              "três_poderes")

#====TOKENIZATION====

votos_unnested <- votos %>%
  unnest_tokens(word, voto) %>%
  drop_na( )

#====STOPWORD REMOVAL====

nomes<-read_xlsx("sw_deffendantsnames.xlsx")

stopwordsPT<-read_xlsx("sw_PT.xlsx")

stopcustom<-read_xlsx("stopwords_8janSTF.xlsx")

votos_unnested<-anti_join(votos_unnested, nomes, by="word")
votos_unnested<-anti_join(votos_unnested, stopwordsPT, by="word")
votos_unnested<-anti_join(votos_unnested, stopcustom, by="word")

#==== TEXT STANDARDIZATION ====

# This process was the result of an expert review of the vocabulary after stopword removal.


votos_unnested$word<-gsub("\\bpode\\b","poder", votos_unnested$word)
votos_unnested$word<-gsub("\\bpoderá\\b","poder", votos_unnested$word)
votos_unnested$word<-gsub("\\bausentes\\b","ausência", votos_unnested$word)
votos_unnested$word<-gsub("\\bausente\\b","ausência", votos_unnested$word)
votos_unnested$word<-gsub("\\bpresente\\b","presença", votos_unnested$word)
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\babsolvido\\b"   = "absolvição",
                                         "\\babsolvida\\b"   = "absolvição",
                                         "\\babsolvidos\\b"  = "absolvição",
                                         "\\babsolvidas\\b"  = "absolvição"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bacolhido\\b"   = "acolhimento",
                                         "\\bacolhida\\b"   = "acolhimento",
                                         "\\bacolhidos\\b"  = "acolhimento",                     
                                         "\\bacolhidas\\b"  = "acolhimento"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bacusado\\b"   = "acusação",
                                         "\\bacusada\\b"   = "acusação",
                                         "\\bacusados\\b"  = "acusação",                     
                                         "\\bacusadas\\b"  = "acusação"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\balegado\\b"   = "alegação",
                                         "\\balegada\\b"   = "alegação",
                                         "\\balegados\\b"  = "alegação",                     
                                         "\\balegadas\\b"  = "alegação"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bcaracterizado\\b"   = "caracterização",
                                         "\\bcaracterizada\\b"   = "caracterização",
                                         "\\bcaracterizados\\b"  = "caracterização",
                                         "\\bcaracterizadas\\b"  = "caracterização"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bcitado\\b"   = "citação",
                                         "\\bcitada\\b"   = "citação",
                                         "\\bcitados\\b"  = "citação",
                                         "\\bcitadas\\b"  = "citação"))                        
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bcomprovado\\b"   = "comprovação",
                                         "\\bcomprovada\\b"   = "compravação",
                                         "\\bcomprovados\\b"  = "compravação",
                                         "\\bcomprovadas\\b"  = "comprovação"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bcondenado\\b"   = "condenação",
                                         "\\bcondenada\\b"   = "condenação",
                                         "\\bcondenados\\b"  = "condenação",
                                         "\\bcondenadas\\b"  = "condenação"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bconhecido\\b"   = "conhecimento",
                                         "\\bconhecida\\b"   = "conhecimento",
                                         "\\bconhecidos\\b"  = "conhecimento",
                                         "\\bconhecidas\\b"  = "conhecimento"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bcriminosa\\b"   = "crimonoso",
                                         "\\bcriminosos\\b"   = "criminoso",
                                         "\\bcriminosas\\b"  = "criminoso"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bdecidido\\b"   = "decisão",
                                         "\\bdecidida\\b"   = "decisão",
                                         "\\bdecididos\\b"  = "decisão",
                                         "\\bdecididas\\b"  = "decisão"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bdemonstrado\\b"   = "demonstração",
                                         "\\bdemonstrada\\b"   = "demonstração",
                                         "\\bdemonstrados\\b"  = "demonstração",
                                         "\\bdemonstradas\\b"  = "demonstração"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bdescrito\\b"   = "descrição",
                                         "\\bdescrita\\b"   = "descrição",
                                         "\\bdescritos\\b"  = "descrição",
                                         "\\bdescritas\\b"  = "descrição"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bdetemrinado\\b"   = "determinação",
                                         "\\bdeterminada\\b"   = "determinação",
                                         "\\bdeterminados\\b"  = "determinação",
                                         "\\bdeterminadas\\b"  = "determinação"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bdifundido\\b"   = "difusão",
                                         "\\bdifundida\\b"   = "difusão",
                                         "\\bdifundidos\\b"  = "difusão",
                                         "\\bdifundidas\\b"  = "difusão"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bdisponibilizado\\b"   = "disponibilização",
                                         "\\bdisponibilizada\\b" = "disponibilização",
                                         "\\bdisponinilizados\\b"  = "disponibilização",
                                         "\\bdisponibilizadas\\b"  = "disponibilização"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\belaborado\\b"   = "elaboração",
                                         "\\belaborada\\b"   = "elaboração",
                                         "\\belaborados\\b"  = "elaboração",
                                         "\\belaboradas\\b"  = "elaboração"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bencaminhado\\b"   = "encaminhamento",
                                         "\\bencaminhada\\b"   = "encaminhamento",
                                         "\\bencaminhados\\b"  = "encaminhamento",
                                         "\\bencaminhadas\\b"  = "encaminhamento"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bentendido\\b"   = "entendimento",
                                         "\\bentendida\\b"   = "entendimento",
                                         "\\bentendidos\\b"  = "entendimento",
                                         "\\bentendidas\\b"  = "entendimento"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bimputado\\b"   = "imputação",
                                         "\\bimputada\\b"   = "imputação",
                                         "\\bimputados\\b"  = "imputação",
                                         "\\bimputadas\\b"  = "imputação"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bincitado\\b"   = "incitação",
                                         "\\bincitada\\b"   = "incitação",
                                         "\\bincitados\\b"  = "incitação",
                                         "\\bincitadas\\b"  = "incitação"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bintimado\\b"   = "intimação",
                                         "\\bintimada\\b"   = "intimação",
                                         "\\bintimados\\b"  = "intimação",
                                         "\\bintimadas\\b"  = "intimaação"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bindividualizado\\b"   = "individualização",
                                         "\\bindividualizda\\b"   = "individualização",
                                         "\\bindidualizados\\b"  = "individualização",
                                         "\\bindividualizadas\\b"  = "individualização"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bjulgado\\b"   = "julgamento",
                                         "\\bjulgada\\b"   = "julgamento",
                                         "\\bjulgados\\b"  = "julgamento",
                                         "\\bjulgadas\\b"  = "julgamento"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\blocalizado\\b"   = "localização",
                                         "\\blocalizada\\b"   = "localização",
                                         "\\blocalizados\\b"  = "localização",
                                         "\\blocalizadas\\b"  = "localização"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bnarrado\\b"   = "narração",
                                         "\\bnarrada\\b"   = "narração",
                                         "\\bnarrados\\b"  = "narração",
                                         "\\bnarradas\\b"  = "narração"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bnecessário\\b"   = "necessidade",
                                         "\\bnecessária\\b"   = "necessidade",
                                         "\\bnecessários\\b"  = "necessidade",
                                         "\\bnecessárias\\b"  = "necessidade"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bnotificado\\b"   = "notificação",
                                         "\\bnotificada\\b"   = "notificação",
                                         "\\bnotiticados\\b"  = "notificação",
                                         "\\bnotificadas\\b"  = "notificação"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bobservado\\b"   = "observação",
                                         "\\bobservada\\b"   = "observação",
                                         "\\bobservados\\b"  = "observação",
                                         "\\bobservadas\\b"  = "observação"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bobtido\\b"   = "obtenção",
                                         "\\bobtida\\b"   = "obtenção",
                                         "\\bobtidos\\b"  = "obtenção",
                                         "\\bobtidas\\b"  = "obtenção"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\boferecido\\b"   = "oferecimento",
                                         "\\boferecida\\b"   = "oferecimento",
                                         "\\boferecidos\\b"  = "oferecimento",
                                         "\\boferecidas\\b"  = "oferecimento"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bpermitido\\b"   = "permissão",
                                         "\\bpermitida\\b"   = "permissão",
                                         "\\bpermitidos\\b"  = "permissão",
                                         "\\bpermitidas\\b"  = "permissão"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bprevisto\\b"   = "previsão",
                                         "\\bprevista\\b"   = "previsão",
                                         "\\bprevistos\\b"  = "previsão",
                                         "\\bprevistas\\b"  = "previsão"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bprotegido\\b"   = "proteção",
                                         "\\bprotegida\\b"   = "proteção",
                                         "\\bprotegidos\\b"  = "proteção",
                                         "\\bprotegidas\\b"  = "proteção"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\brealizado\\b"   = "realização",
                                         "\\brealizada\\b"   = "realização",
                                         "\\brealizados\\b"  = "realização",
                                         "\\brealizadas\\b"  = "realização"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\breconhecido\\b"   = "reconhecimento",
                                         "\\breconhecida\\b"   = "reconhecimento",
                                         "\\breconhecidos\\b"  = "reconhecimento",
                                         "\\breconhecidas\\b"  = "reconhecimento"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\brejeitado\\b"   = "rejeição",
                                         "\\brejeitada\\b"   = "rejeição",
                                         "\\brejeitados\\b"  = "rejeição",
                                         "\\brejeitadas\\b"  = "rejeição"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\brequerido\\b"   = "requerimento",
                                         "\\brequerida\\b"   = "requerimento",
                                         "\\brequeridos\\b"  = "requerimento",
                                         "\\brequeridas\\b"  = "requerimento"))
votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bresponsabilizado\\b"   = "responsabilização",
                                         "\\bresponsabilizada\\b"   = "responsabilização",
                                         "\\bresponsabilizados\\b"  = "responsabilização",
                                         "\\bresponsabilizadas\\b"  = "responsabilização"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\breunido\\b"   = "reunião",
                                         "\\breunida\\b"   = "reunião",
                                         "\\breunidos\\b"  = "reunião",
                                         "\\breunidas\\b"  = "reunião"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\brevogado\\b"   = "revogação",
                                         "\\brevogada\\b"   = "revogação",
                                         "\\brevogados\\b"  = "revogação",
                                         "\\brevogadas\\b"  = "revogação"))

votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bsubstituído\\b"   = "substituição",
                                         "\\bsubstituída\\b"   = "substituição",
                                         "\\bsubstituídos\\b"  = "substituição",
                                         "\\bsubstituídas\\b"  = "substituição"))


votos_unnested$word <- str_replace_all(votos_unnested$word, 
                                       c("\\bvedado\\b"   = "vedação",
                                         "\\bvedada\\b"   = "vedação",
                                         "\\bvedados\\b"  = "vedação",
                                         "\\bvedadas\\b"  = "vedação"))


#manutenção de radical verbal com exclusão de x
votos_unnested$word<-gsub("\\babsolv(?!ição)\\w*\\b", "absolver", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\baleg(?!ação)\\w*\\b", "alegar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bacolh(?!imento)\\w*\\b", "acolher", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bacus(?!ação)\\w*\\b", "acusar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bparticip(?!ação)\\w*\\b", "participar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bcit(?!ação)\\w*\\b", "citar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bcomprov(?!ação)\\w*\\b", "comprovar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bconden(?!ação)\\w*\\b", "condenar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bconhec(?!imento)\\w*\\b", "conhecer", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bdemonstr(?!ação)\\w*\\b", "demonstrar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bdescr(?!ição)\\w*\\b", "descrever", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bdetermin(?!ação)\\w*\\b", "determinar", votos_unnested$word, perl = TRUE)
votos_unnested$word<-gsub("\\bdisponibiliz(?!ação)\\w*\\b", "disponibilizar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bencaminh(?!amento)\\w*\\b", "encaminhar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bentend(?!imento)\\w*\\b", "entender", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bexp(?!osto)\\w*\\b", "expor", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bimput(?!ação)\\w*\\b", "imputar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bincit(?!ação)\\w*\\b", "incitar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bindividualiz(?!ação)\\w*\\b", "individualizar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bjulg(?!amento)\\w*\\b", "julgar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\blocaliz(?!ação)\\w*\\b", "localizar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bnotific(?!ação)\\w*\\b", "notificar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bintim(?!ação)\\w*\\b", "intimar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bobt(?!enção)\\w*\\b", "obter", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bofer(?!ecimento)\\w*\\b", "oferecer", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bped(?!ido)\\w*\\b", "pedir", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\brealiz(?!ação)\\w*\\b", "realizar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\breconh(?!imento)\\w*\\b", "reconhecer", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\brejei(?!ção)\\w*\\b", "rejeitar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\brequer(?!imento)\\w*\\b", "requerer", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\breuni(?!ião)\\w*\\b", "reunir", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\brevog(?!ação)\\w*\\b", "revogar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bsubstitu(?!ição)\\w*\\b", "substituir", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\btrat(?!amento)\\w*\\b", "tratar", votos_unnested$word, perl=TRUE)
votos_unnested$word<-gsub("\\bved(?!ação)\\w*\\b", "vedar", votos_unnested$word, perl=TRUE)


# verbos mantendo só radical
votos_unnested$word<-gsub("\\bacompanh\\w*\\b","acompanhar",votos_unnested$word)
votos_unnested$word<-gsub("\\bacrescent\\w*\\b","acrescentar",votos_unnested$word)
votos_unnested$word<-gsub("\\badot\\w*\\b","adotar",votos_unnested$word)
votos_unnested$word<-gsub("\\bafast\\w*\\b","afastar",votos_unnested$word)
votos_unnested$word<-gsub("\\bafet\\w*\\b","afetar",votos_unnested$word)
votos_unnested$word<-gsub("\\bamold\\w*\\b","amoldar",votos_unnested$word)
votos_unnested$word<-gsub("\\banalis\\w*\\b","analisar",votos_unnested$word)
votos_unnested$word<-gsub("\\bapresent\\w*\\b","apresentar",votos_unnested$word)
votos_unnested$word<-gsub("\\bapt\\w*\\b","aptidão",votos_unnested$word)
votos_unnested$word<-gsub("\\barrol\\w*\\b","arrolar",votos_unnested$word)
votos_unnested$word<-gsub("\\bavent\\w*\\b","aventar",votos_unnested$word)
votos_unnested$word<-gsub("\\bcaracteriz\\w*\\b","caracterizar",votos_unnested$word)
votos_unnested$word<-gsub("\\batu\\w*\\b","atuar",votos_unnested$word)
votos_unnested$word<-gsub("\\bcarreg\\w*\\b","carregar",votos_unnested$word)
votos_unnested$word<-gsub("\\bcomet\\w*\\b","cometer",votos_unnested$word)
votos_unnested$word<-gsub("\\bconced\\w*\\b","conceder",votos_unnested$word)
votos_unnested$word<-gsub("\\bconfig\\w*\\b","configurar",votos_unnested$word)
votos_unnested$word<-gsub("\\bconsid\\w*\\b","considerar",votos_unnested$word)
votos_unnested$word<-gsub("\\bconsolid\\w*\\b","consolidar",votos_unnested$word)
votos_unnested$word<-gsub("\\bculmin\\w*\\b","culminar",votos_unnested$word)
votos_unnested$word<-gsub("\\bdanific\\w*\\b","danificar",votos_unnested$word)
votos_unnested$word<-gsub("\\bdecid\\w*\\b","decidir",votos_unnested$word)
votos_unnested$word<-gsub("\\bdeix\\w*\\b","deixar",votos_unnested$word)
votos_unnested$word<-gsub("\\bdesign\\w*\\b","designar",votos_unnested$word)
votos_unnested$word<-gsub("\\bdifund\\w*\\b", "difundir", votos_unnested$word)
votos_unnested$word<-gsub("\\bdirig\\w*\\b", "dirigir", votos_unnested$word)
votos_unnested$word<-gsub("\\belabor\\w*\\b", "elaborar", votos_unnested$word)
votos_unnested$word<-gsub("\\benvi\\w*\\b", "enviar", votos_unnested$word)
votos_unnested$word<-gsub("\\bestend\\w*\\b", "estender", votos_unnested$word)
votos_unnested$word<-gsub("\\bfoment\\w*\\b", "fomentar", votos_unnested$word)
votos_unnested$word<-gsub("\\bfurt\\w*\\b", "furtar", votos_unnested$word)
votos_unnested$word<-gsub("\\bmajor\\w*\\b", "majorar", votos_unnested$word)
votos_unnested$word<-gsub("\\bnarr\\w*\\b", "narrar", votos_unnested$word)
votos_unnested$word<-gsub("\\bobserv\\w*\\b", "observar", votos_unnested$word)
votos_unnested$word<-gsub("\\bocorr\\w*\\b", "ocorrer", votos_unnested$word)
votos_unnested$word<-gsub("\\bouv\\w*\\b", "ouvir", votos_unnested$word)
votos_unnested$word<-gsub("\\bpermit\\w*\\b", "permitir", votos_unnested$word)
votos_unnested$word<-gsub("\\bprentend\\w*\\b", "pretender", votos_unnested$word)
votos_unnested$word<-gsub("\\bproduz\\w*\\b", "produzir", votos_unnested$word)
votos_unnested$word<-gsub("\\bprosper\\w*\\b", "prosperar", votos_unnested$word)
votos_unnested$word<-gsub("\\bproteg\\w*\\b", "proteger", votos_unnested$word)
votos_unnested$word<-gsub("\\breiter\\w*\\b", "reiterar", votos_unnested$word)
votos_unnested$word<-gsub("\\brelacion\\w*\\b", "relacionar", votos_unnested$word)
votos_unnested$word<-gsub("\\breproduz\\w*\\b", "reproduzir", votos_unnested$word)
votos_unnested$word<-gsub("\\bvis\\w*\\b", "visar", votos_unnested$word)


#Alguns Substantivos-chave do plural para o singular e correções

votos_unnested$word<-gsub("\\bcrimes\\b", "crime", votos_unnested$word)
votos_unnested$word<-gsub("\\bcondutas\\b", "conduta", votos_unnested$word)
votos_unnested$word<-gsub("\\bpoderres\\b", "poderes", votos_unnested$word)
votos_unnested$word<-gsub("\\balegarções\\b", "alegações", votos_unnested$word)
votos_unnested$word<-gsub("\\bexporção\\b", "exposição", votos_unnested$word)
votos_unnested$word<-gsub("\\bcompravaçãos\\b", "comprovações", votos_unnested$word)
votos_unnested$word<-gsub("\\bdescriçãos\\b", "descrições", votos_unnested$word)
votos_unnested$word<-gsub("\\bacusarções\\b", "acusações", votos_unnested$word)
votos_unnested$word<-gsub("\\bacusarória\\b", "acusatória", votos_unnested$word)
votos_unnested$word<-gsub("\\bacusarório\\b", "acusatório", votos_unnested$word)
votos_unnested$word<-gsub("\\bcondenarório\\b", "condenatório", votos_unnested$word)
votos_unnested$word<-gsub("\\bcondenarória\\b", "condenatória", votos_unnested$word)
votos_unnested$word<-gsub("\\bdisponibilizaçãos\\b", "disponibilização", votos_unnested$word)
votos_unnested$word<-gsub("\\bimputarções\\b", "imputação", votos_unnested$word)
votos_unnested$word<-gsub("\\bimputaçãos\\b", "imputação", votos_unnested$word)
votos_unnested$word<-gsub("\\bindividualizaçãos\\b", "individualização", votos_unnested$word)
votos_unnested$word<-gsub("\\bintimaçãos\\b", "intimação", votos_unnested$word)
votos_unnested$word<-gsub("\\bintimarções\\b", "intimação", votos_unnested$word)
votos_unnested$word<-gsub("\\bjulgamentor\\b", "julgamento", votos_unnested$word)
votos_unnested$word<-gsub("\\bjulgamentos\\b", "julgamento", votos_unnested$word)
votos_unnested$word<-gsub("\\bmanifestações\\b", "manifestação", votos_unnested$word)
votos_unnested$word<-gsub("\\bmultidões\\b", "multidão", votos_unnested$word)
votos_unnested$word<-gsub("\\bmultidinário\\b", "multitudinários", votos_unnested$word)
votos_unnested$word<-gsub("\\bnecessidades\\b", "necessidade", votos_unnested$word)
votos_unnested$word<-gsub("\\boferecimentos\\b", "oferecimento", votos_unnested$word)
votos_unnested$word<-gsub("\\bórgãos\\b", "órgão", votos_unnested$word)
votos_unnested$word<-gsub("\\bpedidos\\b", "pedido", votos_unnested$word)
votos_unnested$word<-gsub("\\bpenas\\b", "pena", votos_unnested$word)
votos_unnested$word<-gsub("\\bpersecutórios\\b", "persecutório", votos_unnested$word)
votos_unnested$word<-gsub("\\bpoderr\\b", "poder", votos_unnested$word)
votos_unnested$word<-gsub("\\bpresenças\\b", "presença", votos_unnested$word)
votos_unnested$word<-gsub("\\bprincípios\\b", "princípio", votos_unnested$word)
votos_unnested$word<-gsub("\\bprovas\\b", "prova", votos_unnested$word)
votos_unnested$word<-gsub("\\brequerimentos\\b", "requerimento", votos_unnested$word)
votos_unnested$word<-gsub("\\brevogaçãos\\b", "revogação", votos_unnested$word)
votos_unnested$word<-gsub("\\bsedes\\b", "sede", votos_unnested$word)
votos_unnested$word<-gsub("\\btestemunhas\\b", "testemunha", votos_unnested$word)
votos_unnested$word<-gsub("\\btombados\\b", "tombado", votos_unnested$word)
votos_unnested$word<-gsub("\\bviolentas\\b", "violenta", votos_unnested$word)
votos_unnested$word<-gsub("\\bacusaçãos\\b", "acusação", votos_unnested$word)
votos_unnested$word<-gsub("\\bacusaçãor\\b", "acusação", votos_unnested$word)
votos_unnested$word<-gsub("\\balegaçãos\\b", "alegação", votos_unnested$word)
votos_unnested$word<-gsub("\\bcitaçãos\\b", "citação", votos_unnested$word)
votos_unnested$word<-gsub("\\bcitaçãos\\b", "citação", votos_unnested$word)
votos_unnested$word<-gsub("\\bdemonstraçãos\\b", "demonstração", votos_unnested$word)
votos_unnested$word<-gsub("\\bexporôs\\b", "expor", votos_unnested$word)
votos_unnested$word<-gsub("\\bexporõe\\b", "expor", votos_unnested$word)
votos_unnested$word<-gsub("\\bilícitar\\b", "ilícita", votos_unnested$word)
votos_unnested$word<-gsub("\\bimplícitar\\b", "implícita", votos_unnested$word)
votos_unnested$word<-gsub("\\bimprevisãos\\b", "imprevisão", votos_unnested$word)
votos_unnested$word<-gsub("\\bincitaçãora\\b", "incitação", votos_unnested$word)
votos_unnested$word<-gsub("\\bincitaçãores\\b", "incitação", votos_unnested$word)
votos_unnested$word<-gsub("\\blocalizaçãos\\b", "localização", votos_unnested$word)
votos_unnested$word<-gsub("\\bobtençãos\\b", "obtenção", votos_unnested$word)
votos_unnested$word<-gsub("\\bpeço\\b", "pedir", votos_unnested$word)
votos_unnested$word<-gsub("\\bcabe\\b", "caber", votos_unnested$word)



#Letra A
votos_unnested <- votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("aberto"="abetura","abonatórios"="abonatório",
        "absolutar"="absoluto","absolvido"= "absolvição",
        "absolvida"="absolvição", "absolveu"="absolver",
        "absorvido"="absorver","acampado"="acampamento",
        "acampamentar"="acampamento", "acampamente"="acampamento",
        "\\bacarreta\\b"="acarretar", 
        "aceito"="aceitação", "acolhida"="acolher",
        "acrescentar"="acréscimo","acrescer"="acréscimo",
        "acatem"="acatar","\\bacusatór\\b" = "acusatório",
        "\\bacusatória\\b" = "acusatório","adequado"="adequação",
        "aderente"="adesão","aderido"="adesão","aderência"="adesão",
        "aditar"="aditamento","\\baduz\\b"="aduzir","afirmativo"="afirmação",
        "agregar"="agregação","agrupar"="agrupamento","algemo"="algemar",
        "anexados"="anexar","anulado"="anular","análisar"="analisar",
        "análises"="análise","aparelhos"="apenar","aponte"="apontar",
        "\\bargumenta\\b"="argumentar","\\barm\\b"="armamento","\\barma\\b"="armamento",
        "assegure"="assegurar","\\bassinatur\\b"="assinatura","\\bausenciar\\b"="ausência",
        "autoridades"="autoridade","avenidar"="avenida")
    )
  )

#LETRAS B e C
votos_unnested <-votos_unnested %>%
  mutate( 
    word= str_replace_all(
      word,
      c("\\bbrasílio\\b"="brasília", "\\bcadeio\\b"="cadeia",
        "\\bcaracterísitico\\b"="característica", "\\bcaracterístcos\\b"="característica",
        "\\bcarvano\\b"="caravana", "\\bcarto\\b"="carta", "\\bcauso \\b"="causar", 
        "\\bchamo\\b"="chamar","\\bcláusulo\\b"="cláusula","\\bcoautor\\b"="coautoria",
        "\\bcompareceu\\b"="comparecer","\\bcompatível\\b"="compatibilidade", 
        "\\bcomplexo\\b"="complexidade", "\\bcomposta\\b"="composição", "\\bcompravação\\b"="comprovação", 
        "\\bcompreenser\\b"="compreender","\\bcondutar\\b"="conduta", "\\bconduzida\\b"="condução",
        "\\bcompetênciar\\b"="competência",
        "\\bconstitucioonal\\b"="constitucional","\\bcontextar\\b"="contexto",
        "\\bcredulidader\\b"="credulidade",
        "\\bcunho\\b"="cunhar","\\bcustódio\\b"="custódia","\\bcâmar\\b"="câmara",
        "\\bcâmeras\\b"="câmera","\\bcâmero\\b"="câmera")
    )
  )


#LETRA D

votos_unnested <-votos_unnested %>%
  mutate( 
    word = str_replace_all(
      word,
      c("\\bdeclíniar\\b"="declínio","\\bdecorrênciar\\b"="decorrência", "\\bdeduzer\\b"="deduzir",
        "\\bdefendia\\b"="defender","\\bdefensiva\\b"="defensivo","\\bdefensorer\\b"="defensor ",
        "\\bdefensorar\\b"="defensor","\\bdeferi\\b"="deferir","\\bdeferido\\b"="deferir",
        "\\bdeflagradorar\\b"="deflagração","\\bdelegacio\\b"="delegacia","\\bdemandaria\\b"="demandar",
        "\\bdemander\\b"="demandar","\\bdemocracio\\b"="democracia","\\bdemocrática\\b"="democrático",
        "\\bdenunciada\\b"="denunciar","\\bdenunciado\\b"="denunciar","\\bdenúncer\\b"="denúncia",
        "\\bdescrições\\b"="descrição","\\bdescunhecimemto\\b"="desconhecimento",
        "\\bdesnecessidader\\b"="desnecessidade","\\bdestaco\\b"="destacar","\\bdetém\\b"="deter",
        "\\bdifuser\\b"="difusão", "\\bdiligências\\b"="diligência","\\bdiligêncio\\b"="diligência",
        "\\bdiplomo\\b"="diplomação","\\bdiversos\\b"="diverso","\\bdosimetrio\\b"="dosimetria",
        "\\bdosimetr\\b"="dosimetria","\\bdriver\\b"="drive")
    )
  )


#Letra E	
votos_unnested <-votos_unnested %>%
  mutate( 
    word= str_replace_all(
      word,
      c("\\beletrônicar\\b"="eletrônico","\\bementar\\b"="ementa", "\\bemprego\\b"="empregar",
        "\\bempreitar\\b"="empreitada","\\bencaminhamentar\\b"="encaminhar","\\bencontre\\b"="encontrar",
        "\\benfrentamentar\\b"="enfrentamento","\\bentendimentar\\b"="entender","\\bentradar\\b"="entrar",
        "\\bentrado\\b"="entrar","\\bentraramente\\b"="entrar","\\bentrarer\\b"="entrar", 
        "\\benvolvimentar\\b"="envolvimento","\\bequiparamento\\b"="equiparação","\\besclareceu\\b"="esclarecer",
        "\\besfer\\b"="esfera","\\besferas\\b"="esfera","\\besplanado\\b"="esplanada", "\\bespero\\b"="esperar",
        "\\bespontânea\\b"="espontâneo","\\bespéciar\\b"="espécie","\\bessencial\\b"="essência",
        "\\bestabeleceu\\b"="estabelecer","\\bestabilidader\\b"="estabilidade","\\besteiro\\b"="esteira",
        "\\bestilingar\\b"="estilingue","\\bestátuo\\b"="estátua","\\betapar\\b"="etapa",
        "\\bevidenciado\\b"="evidenciar","\\bexcessivo\\b"="excesso","\\bexecutora\\b"="executor",
        "\\bexecutorar\\b"="executor","\\bexerceria\\b"="exercer","\\bexerceu\\b"="exercer",
        "\\bexerça\\b"="exercer","\\bexerço\\b"="exercer","\\bexercíciar\\b"="exercício",
        "\\bexista\\b"="existir","\\bexistente\\b"="existir","\\bexistêncer\\b"="existência",
        "\\bextemporaneidader\\b"="extemporaneidade","\\bexércitar\\b" ="exército")
    )
  )

#LETRAS F e G

votos_unnested <- votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bfaculto\\b"="facultar","\\bfamíler\\b"="familiar","\\bfilmagir\\b"="filmagem",
        "\\bfixo\\b"="fixar","\\bflagrancial\\b"="flagrante","\\bformais\\b"="formal","\\bformalidado\\b"="formalizar", 
        "\\bformulada\\b"="formular","\\bformulado\\b"="formular","\\bformulo\\b"="formular",
        "\\bforço\\b"="força","\\bfoto\\b"="fotografia","\\bfrauder\\b"="fraude","\\bfundamentado\\b"="fundamentar",
        "\\bfórmulo\\b"="fórmula","\\bgabiente\\b"="gabinete","\\bgabineter\\b"="gabinete",
        "\\bgarantu\\b"="garantir","\\bgerado\\b"="gerar","\\bgradis\\b"="gradil","\\bgravado\\b"="gravar",
        "\\bgravoso\\b"="gravidade","\\bgravíssimo\\b"="gravidade")
    )
  )


#LETRAS H e I 

votos_unnested <- votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,	
      c("\\bhistóricos\\b"="histórico", "\\bhomologado\\b"="homologar", "\\bhomologada\\b"="homologar",
        "\\bhumana\\b"="humano", "\\bhumanos\\b"="humano", "\\bigual\\b"="igualdade", "\\bilicituder\\b"="ilicitude",
        "\\bimparcialidader\\b"="imparcialidade", "\\bimpedimentar\\b"="impedir", "\\bimportâncer\\b"="importância",
        "\\bimpossibilidader\\b"="impossibilidade", "\\bimprocedente\\b"="improcedência","\\bincido\\b"="incidir", 
        "\\bincompatibilidade\\b"="incompatível", "\\bincompetênciar"="incompetência", "\\bincorreu\\b"="incorrer","\\bincursa\\b"="incurso",
        "\\bindeferer\\b"="indeferir","\\bindeferi\\b"="indeferir","\\bindeferida\\b"="indeferir",
        "\\bindeferido\\b"="indeferir","\\bindefiro\\b"="indeferir","\\bindependente\\b"="independência",
        "\\bindeterminado\\b"="indeterminação","\\binduzer\\b"="induzir", "\\bindícios\\b"="indício",
        "\\bineficácio\\b"="ineficácia","\\bineptar\\b"="inepta","\\binexistenciar b"="inexistência",
        "\\binfluencie\\b"="influenciar","\\binformo\\b"="informar","\\binformático\\b"="informática",
        "\\bingresso\\b"="ingressar","\\binocenciar\\b"="inocência", "\\binocente\\b"="inocência",
        "\\binquietuder\\b"="inquietude", "\\binquirida\\b"="inquirir", "\\binquirido\\b"="inquirir",
        "\\binquérever\\b"="inquérito", "\\binsanabill\\b"="insanável", "\\binscrito\\b"="inscrever",
        "\\binserido\\b"="inserir", "\\binstagrar\\b"="instagram", "\\binstigo\\b"="instigação",  
        "\\binstrutória\\b"="instrução", "\\binstrutório\\b"="instrução", "\\binsuficienciar\\b"="insuficiência",
        "\\binsuflamentar\\b"="insuflar", "\\binsuflamento\\b"="insuflar", "\\binsurgênciar\\b"="insurgência",
        "\\bintimarção\\b"="intimar", "\\binvadio\\b"="invadir","\\binvestigado\\b"="investigação", 
        "\\binvestigada\\b"="investigação","\\binépcer\\b"="inépcia", "\\biphonir\\b"="iphone", "\\bincluser"="incluir")
    )
  )

#LETRAS J, L e M

votos_unnested <- votos_unnested %>%
  mutate(
    word =str_replace_all(
      word,
      c("\\bjanelo\\b"="janela","\\bjudiciais\\b"="judicial","\\bjudiciários\\b"="judiciário",
        "\\bjulgamentar\\b"="julgar","\\bjulgamente\\b"="julgamento","\\bjuntasse\\b"="juntar",
        "\\bjunte\\b"="juntar","\\bjuntem\\b"="juntar","\\blavrar\\b"="lavratura","\\blavrado\\b"="lavrar",
        "\\blegal\\b"="legalidade","\\blegalmente\\b"="legalidade","\\blegitimamente\\b"="legitimidade",
        "\\blegítimar\\b"="legitimidade","\\blegítima\\b"="legitimidade","\\blesivo\\b"="lesividade",
        "\\blesõe\\b"="lesividade","\\bmanado\\b"="manada","\\bmanifestarer\\b"="manifestar",
        "\\bmanifestavar\\b"="manifestar", "\\bmarcho\\b"="marcha","\\bmarcharer\\b"="marcha",
        "\\bmasso\\b"="massa","\\bmedicinar\\b"="medicina","\\bmedicino\\b"="medicina",
        "\\bmencionado\\b"="mencionar","\\bmencional\\b"="mencionar","\\bmobilizar\\b"="mobilização",
        "\\bmochile\\b"="mochila","\\bmochilo\\b"="mochila","\\bmoldes\\b"="molde",
        "\\bmonitorado\\b"="monitoramento","\\bmontado\\b"="montar","\\bmídio\\b"="mídia") 
    )
  )


#LETRAS N, O e P

votos_unnested <- votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bnatale\\b"="natal", "\\bnaturezar\\b"="natureza", "\\bnecessidader\\b"="necessidade",
        "\\bnego\\b"="negar","\\bnoticia\\b"="notícia","\\bnulidades\\b"="nulidade","\\bnullité\\b"="nulidade",
        "\\bnulo\\b"="nulidade","\\bobedecido\\b"="obedecer","\\bobjetivos\\b"="objetivo", 
        "\\boferecimentar\\b"="oferecer",
        "\\bobrigar\\b"="obrigatoriedade","\\bobrigatório\\b"="obrigatoriedade","\\boficiasse\\b"="oficiar",
        "\\boficio\\b"="ofício","\\boitivo\\b"="oitiva","\\boportunidader\\b"="oportunidade",
        "\\boportunizado\\b"="oportunizar","\\bordeira\\b"="ordem","\\boriginado\\b"="origem",
        "\\boriginem\\b"="origem", "\\bônu\\b"="ônus", "\\bônibu\\b"="ônibus",
        "\\bparcial\\b"="parcialidade","\\bpasso\\b"="passar",
        "\\bpatrimonial\\b"="patrimônio","\\bpatrioto\\b"="patriota","\\bpauto\\b"="pauta",
        "\\bperda\\b"="perder","\\bperdar\\b"="perder","\\bpericio\\b"="pericial","\\bpermanenciar\\b"="permanência",
        "\\bperícer\\b"="perícia","\\bpessoar\\b"="pessoa","\\bpetisto\\b"="petista","\\bpeço\\b"="pedir",
        "\\bporto\\b"="porte","\\bpossibilidader\\b"="possibilidade","\\bpossua\\b"="possuir","\\bpossui\\b"="possuir",
        "\\bpossuem\\b"="possuir","\\bpossuía\\b"="possuir","\\bpossuío\\b"="possuir",
        "\\bpraticante\\b"="prática","\\bpraticada\\b"="prática","\\bpratico\\b"="prática",
        "\\bpraçar\\b"="praça","\\bpreenchido\\b"="preencher","\\bprendido\\b"="prender",
        "\\bprerrogativo\\b"="prerrogativa","\\bprescindar\\b"="prescindir","\\bpresencer\\b"="presenciar",
        "\\bpresa\\b"="prisão","\\bpreso\\b"="prisão","\\bpreviser\\b"="prever","\\bprocedente\\b"="procedência",
        "\\bprocessa\\b"="processo","\\bprocessamentar\\b"="processamento","\\bproclamo\\b"="proclamar",
        "\\bproferi\\b"="proferir","\\bproibi\\b"="proibição","\\bproibitivo\\b"="proibição",
        "\\bproporcionalidader\\b"="proporcionalidade","\\bpropositurar \\b"="propositura",
        "\\bpropriedader\\b"="propriedade","\\bpropósger\\b"="propósito","\\bprosseguimentar\\b"="prosseguimento",
        "\\bprovidêncio\\b"="providência","\\bprovo\\b"="provar", "\\bpublicado\\b"="publicar",
        "\\bpugna\\b"="pugnar","\\bpugno\\b"="pugnar", "\\bperício\\b"="perícia", "\\bpraticaramente\\b"="praticar") 
      
    )
  )


#LETRAS Q e R

votos_unnested <-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bqualificada\\b"="qualificar", "\\bqualificado\\b"="qualificar","\\bqueimo\\b"="queimar",
        "\\bqueria\\b"="querer","\\brampar\\b"="rampa","\\brecebida\\b"="recebido", "\\brecebimentar\\b"="recebimento",
        "\\brecebir\\b"="receber","\\brecluser\\b"="reclusão","\\brecluso\\b"="reclusão", 
        "\\brecíprocar\\b"="recíproco", "\\bregimir\\b"="regime","\\bregro\\b"="regra","\\bremessar\\b"="remessa",
        "\\bremesso\\b"="remessa","\\brepresento\\b"="representar","\\brequerimentar\\b"="requerimento",
        "\\brespalr\\b"="respaldar","\\bressalte\\b"="ressaltar","\\bressalto\\b"="ressaltar",
        "\\bresultarar\\b"="resultar","\\bresultasse\\b"="resultar","\\bretomado\\b"="retormar",
        "\\breunirão\\b"="reunir","\\brompeu\\b"="romper","\\brouber\\b"="roubar ","\\bruo\\b"="rua",
        "\\brupturo\\b"="ruptura") 
    )
  )


#LETRAS S, T, U e V

votos_unnested <-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bseder\\b"="sede","\\bseguida\\b"="seguir","\\bseguido\\b"="seguir","\\bseguio\\b"="seguir",
        "\\bsegurancer\\b"="segurança", "\\bsemiabetura\\b"="semiaberto",
        "\\bsociedader\\b"="sociedade","\\bsolicito\\b"="solicitação","\\bsubsistar\\b"="subsistência",
        "\\bsuficientemente\\b"="suficiência","\\bsuficiênciar\\b"="suficiência","\\bsuspenso\\b"="suspensão",
        "\\bsíntesar\\b"="síntese","\\bsúmular\\b"="súmula","\\bsúmulo\\b"="súmula","\\btardia\\b"="tardio",
        "\\btelar\\b"="tela","\\btentativo\\b"="tentativa","\\btestemunhos\\b"="testemunho",
        "\\btornozeleiro\\b"="tornozeleira","\\btrancamentar\\b"="trancamento","\\btranscrito\\b"="transcrição",
        "\\btransmisser\\b"="transmissão","\\btropo\\b"="tropa","\\btrâmitir\\b"="trâmite",
        "\\btécnicos\\b"="técnico","\\btípicas\\b"="típico","\\btípica\\b"="típico","\\bunida\\b"="unidade",
        "\\burno\\b"="urna","\\busada\\b"="usar","\\bveiculado\\b"="veicular","\\bveio\\b"="vir",
        "\\bverifica\\b"="verificar","\\bverifico\\b"="verificar","\\bviola\\b"="violar",
        "\\bviolenciar\\b"="violência","\\bvirtuder\\b"="virtude","\\bvoluntário\\b"="voluntariedade",
        "\\bvoluntária\\b"="voluntariedade","\\bvídeos\\b"="vídeo") 
    )
  )



votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\babetura\\b" = "abertura","\\baboliçãoviolenta\\b" = "abolição_violenta",
        "\\babonatórias\\b" = "abonatório","\\babordá\\b" = "abordar", "\\babsolverê\\b" = "absolver", 
        "\\babstrata\\b" = "abstrato","\\babstratas\\b" = "abstrato", "\\babstratos\\b" = "abstrato",
        "\\bacabara\\b" = "acabar", "\\bacampamentos\\b" = "acampamento", "\\baceitas\\b" = "aceitar", 
        "\\bacontecimentos\\b" = "acontecimento", "\\bacordos\\b" = "acordo", "\\bacusações\\b" = "acusação", 
        "\\badentar\\b" = "adentrar", "\\badesãos\\b" = "adesão", "\\bafirmando\\b" = "afirmar",
        "\\bagentes\\b" = "agente",  "\\bagiam\\b" = "agir", "\\bagia\\b" = "agir", "\\bagravantes\\b" = "agravante",
        "\\bagredidos\\b" = "agredido", "\\bagressões\\b" = "agressão", "\\bagrupamentoem\\b" = "agrupamento",
        "\\balegações\\b" = "alegação", "\\batividades\\b" = "atividade", "\\baumento\\b" = "aumentar",
        "\\bautorias\\b" = "autoria", "\\balmejado\\b" = "almejar", "\\balmejando\\b" = "almejar",
        "\\bamotinada\\b" = "amotinar", "\\bamotinados\\b" = "amotinar", "\\banexos\\b" = "anexo",
        "\\bantecipada\\b" = "antecipação", "\\bantecipado\\b" = "antecipação", 
        "\\banteriores\\b" = "anterior", "\\bantidemocráticas\\b" = "antidemocrático", 
        "\\bantidemocrática\\b" = "antidemocrático", "\\bantidemocráticos\\b" = "antidemocrático",
        "\\banuncia\\b" = "anunciar", "\\banunciado\\b" = "anunciar", "\\bapontados\\b" = "apontado",
        "\\bapontam\\b" = "apontar", "\\bapontando\\b" = "apontar", "\\bapontou\\b" = "apontar",
        "\\bapreciados\\b" = "apreciado", "\\bapreendidos\\b" = "apreendido", "\\bapuradas\\b" = "apurar", 
        "\\bapurada\\b" = "apurar", "\\bapurado\\b" = "apurar", "\\bapurados\\b" = "apurar", 
        "\\bargumentos\\b" = "argumento","\\barmados\\b" = "armado", "\\barquivos\\b" = "arquivo",
        "\\barregimentando\\b" = "arregimentar", "\\bartefatos\\b" = "artefato", "\\baspectos\\b" = "aspecto",
        "\\bassegura\\b" = "assegurar", "\\bassegurada\\b" = "assegurar", "\\bassociados\\b" = "associado",
        "\\bassociando\\b" = "associar", "\\bataques\\b" = "ataque", "\\batendimentos\\b" = "atendimento",
        "\\batentado\\b" = "atentado", "\\batentatórias\\b" = "atentatório", "\\batentatórios\\b" = "atentatório", 
        "\\batenuantes\\b" = "atenuante")
    )
  )

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bbandeiras\\b" = "bandeira", "\\bbarracas\\b" = "barraca", "\\bbarreiras\\b" = "barreira",
        "\\bbarricadas\\b" = "barricada", "\\bbarulhos\\b" = "barulho", "\\bbastando\\b" = "bastar",
        "\\bbastaria\\b" = "bastar", "\\bbastasse\\b" = "bastar", "\\bbenefícios\\b" = "benefício",
        "\\bbloqueios\\b" = "bloqueio", "\\bbrancas\\b" = "branca", "\\bbrasileiras\\b" = "brasileira",
        "\\bbrasileiros\\b" = "brasileiro", "\\bbrasilia\\b" = "brasília", "\\bbuscava\\b" = "buscar",
        "\\bbuscavam\\b" = "buscar", "\\bcabendo\\b" = "caber", "\\bcaixas\\b" = "caixa", "\\bcalculada\\b" = "calculado",
        "\\bcalculados\\b" = "calculado", "\\bcaminhões\\b" = "caminhão","\\bcamuflados\\b" = "camuflagem",
        "\\bcamufladas\\b" = "camuflagem", "\\bcapazes\\b" = "capaz", "\\bcaracterísticas\\b" = "característica",
        "\\bcaravanas\\b" = "caravana", "\\bcausados\\b" = "causado", "\\bcausais\\b" = "causal",
        "\\bcausando\\b" = "causar","\\bcelulares\\b" = "celular",  "\\bcertidões\\b" = "certidão",
        "\\bchamadas\\b" = "chamada", "\\bchamados\\b" = "chamado", "\\bchegado\\b" = "chegar", 
        "\\bchegou\\b" = "chegar", "\\bchegaram\\b" = "chegar", "\\bcheios\\b" = "cheio", "\\bcidadãos\\b" = "cidadão",
        "\\bcircunstâncias\\b" = "circunstância", "\\bclara\\b" = "clareza", "\\bclaramente\\b" = "clareza",
        "\\bclaro\\b" = "clareza", "\\bcoautorias\\b" = "coatoria", "\\bcongnitivo\\b" = "cognição",
        "\\bcognitiva\\b" = "cognição", "\\bcolaciona\\b" = "colacionar", "\\bcolacionadas\\b" = "colacionar",
        "\\bcoletivos\\b" = "coletivo", "\\bcoligidos\\b" = "coligido", "\\bcomeçaram\\b" = "começar", 
        "\\bcomissivamente\\b" = "comissivo", "\\bcomissivas\\b" = "comissivo", "\\bcompartilhadas\\b" = "compartilhamento",
        "\\bcompartilhado\\b" = "compartilhamento", "\\bcompartilhados\\b" = "compartilhamento", "\\bcomponentes\\b" = "componente", 
        "\\bcomportamentos\\b" = "comportamento", "\\bcomprometida\\b" = "comprometimento", "\\bconcorrem\\b" = "concorrer",
        "\\bconcorrendo\\b" = "concorrer", "\\bconcorreu\\b" = "concorrer", "\\bconcorria\\b" = "concorrer", "\\bconcreta\\b" = "concreto",
        "\\bcondenatória\\b" = "condenatório", "\\bcondições\\b" = "condição", "\\bconduzido\\b" = "conduzir",
        "\\bconfessaram\\b" = "confessar", "\\bconfessou\\b" = "confessar", "\\bconfirma\\b" = "confirmar", 
        "\\bconfirmada\\b" = "confirmar", "\\bconfirmam\\b" = "confirmar", "\\bconfirmou\\b" = "confirmar", 
        "\\bconfrontada\\b" = "confrontar", "\\bconfrontadas\\b" = "confrontar", "\\bconfrontado\\b" = "confrontar",
        "\\bconfrontados\\b" = "confrontar", "\\bconfrontou\\b" = "confrontar", "\\bconheçam\\b" = "conheça",
        "\\bconseguiram\\b" = "conseguir", "\\bconseguiu\\b" = "conseguir", "\\bconsequências\\b" = "consequência", 
        "\\bconsigna\\b" = "consignar", "\\bconsignou\\b" = "consignar", "\\bconsistentes\\b" = "consistente", 
        "\\bconsta\\b" = "constar", "\\bconstam\\b" = "constar", "\\bconstou\\b" = "constar",   
        "\\bconstata\\b" = "constatar", "\\bconstatada\\b" = "constatar", "\\bconstatados\\b" = "constatar",
        "\\bconstatou\\b" = "constatar", "\\bconstitui\\b" = "constituir", "\\bconstituindo\\b" = "constituir", 
        "\\bconstituídas\\b" = "constituída", "\\bconstituídos\\b" = "constituído", "\\bconsumam\\b" = "consumar",
        "\\bconsumando\\b" = "consumar", "\\bcontribuiu\\b" = "contribuir", "\\bcontribuíram\\b" = "contribuir", 
        "\\bcontribuía\\b" = "contribuir", "\\bcontribuições\\b" = "contribuição", "\\bcontrárias\\b" = "contrário",
        "\\bcovergia\\b" = "convergir", "\\bconvergirem\\b" = "convergir", "\\bconverte\\b" = "converter",
        "\\bconvertida\\b" = "converter", "\\bconvocações\\b" = "convocação", "\\bcorresponde\\b" = "corresponder",
        "\\bcorrespondem\\b" = "corresponder", "\\bcorrobora\\b" = "corroborar", "\\bcorroborada\\b" = "corroborar", 
        "\\bcorroborados\\b" = "corroboram", "\\bcorroborando\\b" = "corroborar", "\\bcrianças\\b" = "criança",
        "\\bcriminais\\b" = "criminal", "\\bcrimonoso\\b" = "criminoso", "\\bcritérios\\b" = "critério", 
        "\\bcríticas\\b" = "crítica", "\\bcâmaras\\b" = "câmara")
    )
  )

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bdeclarado\\b" = "declarar", "\\bdeclarações\\b" = "declaração",  "\\bdecorrido\\b" = "decorrer",
        "\\bdefendeu\\b" = "defender", "\\bdefensivas\\b" = "defensivo", "\\bdeferiam\\b" = "deferimento",
        "\\bdeferida\\b" = "deferimento", "\\bdefinidas\\b" = "definido", "\\bdefinidos\\b" = "definido",
        "\\bdefiniu\\b" = "definir", "\\bdelineadas\\b" = "delineado", "\\bdelitos\\b" = "delito", 
        "\\bdelitivas\\b" = "delitiva","\\bdelitivos\\b" = "delitivo", "\\bdelituosa\\b" = "delitivo",
        "\\bdelituosas\\b" = "delitivo", "\\bdelituoso\\b" = "delitivo", "\\bdemocráticas\\b" = "democrático",
        "\\bdemocráticos\\b" = "democrático", "\\bdenotam\\b" = "denotar", "\\bdenotavam\\b" = "denotar",
        "\\bdenotou\\b" = "denotar", "\\bdenunciadas\\b" = "denunciado", "\\bdenunciados\\b" = "denunciado",
        "\\bdenúncias\\b" = "denúncia", "\\bdepartamentos\\b" = "departamento", "\\bdepoimentos\\b" = "depoimento",
        "\\bdepredados\\b" = "depredação", "\\bdepredado\\b" = "depredação", "\\bdepredando\\b" = "depredação",
        "\\bdepredou\\b" = "depredação", "\\bdepredações\\b" = "depredação", "\\bdeputados\\b" = "deputado",
        "\\bdesbordaram\\b" = "desbordar", "\\bdesbordou\\b" = "desbordar", "\\bdesceram\\b" = "descer",
        "\\bdesceu\\b" = "descer", "\\bdescumprimentos\\b" = "descumprimento", "\\bdesdobramentos\\b" = "desdobramento",
        "\\bdesenrolam\\b" = "desenrolar", "\\bdesenrolou\\b" = "desenrolar", "\\bdesfavoráveis\\b" = "desfavorável",
        "\\bdeslocando\\b" = "deslocar", "\\bdeslocou\\b" = "deslocar", "\\bdestacado\\b" = "destacar", 
        "\\bdestacados\\b" = "destacar", "\\bdestacando\\b" = "destacar", "\\bdestacou\\b" = "destacar","\\bdestinadas\\b" = "destinação","\\bdestinados\\b" = "destinação",
        "\\bdestinado\\b" = "destinação","\\bdestruições\\b" = "destruição", "\\bdestruí\\b" = "destruir",
        "\\bdestruía\\b" = "destruir", "\\bdesígnios\\b" = "desígnio", "\\bdetalhada\\b" = "detalhamento",
        "\\bdetalhado\\b" = "detalhamento", "\\bdetida\\b" = "detido", "\\bdetidos\\b" = "detido",
        "\\bdevidas\\b" = "devida","\\bdificuldades\\b" = "dificuldade", "\\bdifusos\\b" = "difuso",
        "\\bdimensões\\b" = "dimensão", "\\bdirecionadas\\b" = "direcionado", "\\bdirecionada\\b" = "direcionado",
        "\\bdirecionados\\b" = "direcionado", "\\bdiscursos\\b" = "discurso", "\\bdispositivos\\b" = "dispositivo",
        "\\bdisposta\\b" = "disposição", "\\bdispostos\\b" = "disposição", "\\bdispostas\\b" = "disposição",
        "\\bdispõe\\b" = "dispor", "\\bdivulgados\\b" = "divulgado", "\\bdoloso\\b" = "dolo",
        "\\bduradoura\\b" = "duradouro")
    )
  )

#LETRAS E e F 

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bedifícios\\b"="edifício", "\\befeitos\\b"="efeito", "\\befetivos\\b"="efetivo", "\\befetiva\\b"="efetivo",
        "\\beleitos\\b"="eleito","\\beleições\\b"="eleição", "\\belementos\\b"="elemento", "\\beletrônicos\\b"="eletrônico",
        "\\bencadeadas\\b"="encadeado","\\bencadeada\\b"="encadeado","\\bencontradas\\b"="encontrar", "\\bencontrados\\b"="encontrar",
        "\\bencontrado\\b"="encontrar", "\\bencontrava\\b"="encontrar", "\\bencontravam\\b"="encontrar", "\\bensina\\b"="ensinar",
        "\\bensinado\\b"="ensinar", "\\bentradas\\b"="entrada","\\bentram\\b"="entrar", "\\bentra\\b"="entrar",
        "\\benvolve\\b"="envolver", "\\benvolvem\\b"="envolver", "\\benvolvendo\\b"="envolver", "\\benvolveram\\b"="envolver",
        "\\benvolvidos\\b"="envolvimento", "\\bequipamentos\\b"="equipamento", "\\bescudos\\b"="escudo", "\\bespaços\\b"="espaço",
        "\\bespecífica\\b"="específico","\\bespecíficas\\b"="específico","\\bespecíficos\\b"="específico", "\\bessenciais\\b"="essencial",
        "\\bestabelece\\b"="estabelecer", "\\bestabelecida\\b"="estabelecido","\\bestabelecidos\\b"="estabelecido",
        "\\bestimados\\b"="estimado","\\bestilingues\\b"="estilingue","\\bestruturas\\b"="estrutura", "\\beventos\\b"="evento",
        "\\beventuais\\b"="eventual","\\bevidenciada\\b"="evidenciado", "\\bevidenciados\\b"="evidenciado", "\\bevidenciando\\b"="evidenciar",
        "\\bevidenciam\\b"="evidenciar", "\\bexecutores\\b"="executor", "\\bexercito\\b"="exército", "\\bexigidos\\b"="exigido",
        "\\bexigindo\\b"="exigir","\\bexistirá\\b"="existir", "\\bexiste\\b"="existir", "\\bexporão\\b"="expor",
        "\\bexternada\\b"="externado","\\bextraídas\\b"="extraído","\\bextraídos\\b"="extraído", "\\bextremistas\\b"="extremista",
        "\\bfacas\\b"="faca","\\bfatos\\b"="fato", "\\bfica\\b"="ficar","\\bficam\\b"="ficar", "\\bficando\\b"="ficar",
        "\\bficou\\b"="ficar", "\\bfiguras\\b"="figura", "\\bfinalidades\\b"="finalidade", "\\bfirmado\\b"="firmar",
        "\\bfirmaram\\b"="firmar", "\\bfixados\\b"="fixado","\\bfixada\\b"="fixado", "\\bfixadas\\b"="fixado",
        "\\bfixará\\b"="fixar", "\\bformuladas\\b"="formulado", "\\bformulados\\b"="formulado", "\\bformulando\\b"="formular",
        "\\bformulou\\b"="formular", "\\bfotografias\\b"="fotografia","\\bfrentes\\b"="frente", "\\bfundamentais\\b"="fundamental",
        "\\bfísicas\\b"="física")
    )
  )

# LETRAS G, H e I

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bgarantias\\b" = "garantia", "\\bgarantindo\\b" = "garantir", "\\bgastos\\b" = "gasto", "\\bgerando\\b" = "gerar",
        "\\bgolpistas\\b" = "golpista", "\\bgovernos\\b" = "governo", "\\bgravações\\b" = "gravação", "\\bgudes\\b" = "gude",
        "\\bhaverem\\b" = "haver", "\\bhaveria\\b" = "haver", "\\bhaverá\\b" = "haver", "\\bhaviam\\b" = "haver",
        "\\bhipóteses\\b" = "hipótese", "\\bideias\\b" = "ideia", "\\bidentificadas\\b" = "identificado", "\\bidentificada\\b" = "identificado", 
        "\\bidênticas\\b" = "idêntica","\\bilegais\\b" = "ilegal", "\\bimagens\\b" = "imagem", "\\bimpedindo\\b" = "impedir",
        "\\bimpostas\\b" = "imposta", "\\bimprescindíveis\\b" = "imprescindível", "\\bimpróprias\\b" = "imprópria",
        "\\bimpulsionadas\\b" = "impulsionar", "\\bimpulsionado\\b" = "impulsionar", "\\bincide\\b" = "incidir",
        "\\bincidem\\b" = "incidir", "\\bincidindo\\b" = "incidir", "\\binclui\\b" = "incluir", "\\bincluindo\\b" = "incluir",
        "\\bincompetentes\\b" = "incompetente", "\\bincorre\\b" = "incorrer", "\\bincriminadores\\b" = "incriminador",
        "\\bindica\\b" = "indicar", "\\bindicada\\b" = "indicar","\\bindicadas\\b" = "indicar", "\\bindicado\\b" = "indicar",
        "\\bindicados\\b" = "indicar", "\\bindicavam\\b" = "indicar", "\\bindispensáveis\\b" = "indispensável",
        "\\bindividuais\\b" = "individual", "\\bindivíduos\\b" = "indivíduo", "\\bindividualizar\\b" = "individualização",
        "\\binestimáveis\\b" = "inestimável","\\binfluenciado\\b" = "influenciar","\\binfluenciou\\b" = "influenciar",
        "\\binfluências\\b" = "influência", "\\binformações\\b" = "informação", "\\binfrações\\b" = "infração", 
        "\\bingressaram\\b" = "ingressar", "\\bingressou\\b" = "ingressar", "\\biniciou\\b" = "iniciar", "\\biniciaram\\b" = "iniciar",
        "\\binquiridos\\b" = "inquirido","\\binquiridas\\b" = "inquirido", "\\binquéritos\\b" = "inquérito",
        "\\binsatisfeita\\b" = "insatisfeito","\\binsatisfeitas\\b" = "insatisfeito", "\\binserem\\b" = "inserir",
        "\\binseria\\b" = "inserir","\\binsira\\b" = "inserir", "\\binstalações\\b" = "instalação", "\\binstaurados\\b" = "instaurado",
        "\\binstitucionais\\b" = "institucional","\\binstituições\\b" = "instituição", "\\binstrumentos\\b" = "instrumento",
        "\\binstruções\\b" = "instrução","\\binsuflando\\b" = "insuflar","\\binsuflava\\b" = "insuflar", "\\binsuflou\\b" = "insuflar",
        "\\bintegrantes\\b" = "integrante", "\\bintegrando\\b" = "integrar", "\\bintegrava\\b" = "integrar",
        "\\bintelectuais\\b" = "intelectual", "\\binterligadas\\b" = "interligado", "\\binterligados\\b" = "interligado",
        "\\binternacionais\\b" = "internacional", "\\binternos\\b" = "interno", "\\binvadia\\b" = "invadir", 
        "\\binvadimos\\b" = "invadir", "\\binvadiram\\b" = "invadir","\\binvadissem\\b" = "invadir",
        "\\binvadiu\\b" = "invadir", "\\binvasores\\b" = "invasor", "\\binvasora\\b" = "invasor", "\\binvasões\\b" = "invasão",
        "\\binvestigadas\\b" = "investigado","\\binvestigados\\b" = "investigado", "\\binvestigações\\b" = "investigação",
        "\\binúmeras\\b" = "inúmeros","\\bitens\\b" = "item")
    )
  )

#LETRAS J, L e M

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bjuntada\\b" = "juntar", "\\bjuntado\\b" = "juntar", "\\bjuntados\\b" = "juntar", "\\bjuntou\\b" = "juntar",
        "\\bjurídica\\b" = "jurídico", "\\bjurídicos\\b" = "jurídico", "\\bjuízos\\b" = "juízo", "\\blacrimogênio\\b" = "lacrimogêneo",
        "\\blamentáveis\\b" = "lamentável","\\blegais\\b" = "legalidade", "\\blegítimos\\b" = "legítimo", "\\blevaram\\b" = "levar",
        "\\blevou\\b" = "levar", "\\blimites\\b" = "limite","\\blimitando\\b" = "limitar", "\\blimitou\\b" = "limitar",
        "\\blinhas\\b" = "linha","\\blives\\b" = "live", "\\blivres\\b" = "livre", "\\blogísticas\\b" = "logística", "\\blíderes\\b" = "líder",
        "\\blógica\\b" = "lógico","\\bmanifestantes\\b" = "manifestante", "\\bmatemáticos\\b" = "matemática", "\\bmedidas\\b" = "medida",
        "\\bmembros\\b" = "membro","\\bmencionados\\b" = "mencionar", "\\bmencionada\\b" = "mencionar","\\bmencionadas\\b" = "mencionar",
        "\\bmencionou\\b" = "mencionar","\\bmencionando\\b" = "mencionar", "\\bmensagens\\b" = "mensagem","\\bmochilas\\b" = "mochila",
        "\\bmontadas\\b" = "montagem","\\bmontados\\b" = "montagem", "\\bmontaram\\b" = "montagem", "\\bmotivos\\b" = "motivo",
        "\\bmovimentos\\b" = "movimento","\\bmultitudinária\\b" = "multitudinário", "\\bmultitudinárias\\b" = "multitudinário",
        "\\bmultitudinários\\b" = "multitudinário", "\\bmínima\\b" = "mínimo", "\\bmínimas\\b" = "mínima", "\\bmínimos\\b" = "mínimo")
    )
  )

#LETRAS N, O e P

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bnascida\\b" = "nascido", "\\bnegativas\\b" = "negativo", "\\bnegativos\\b" = "negativo", "\\bnegociações\\b" = "negociação",
        "\\bnotícias\\b" = "notícia", "\\bnoções\\b" = "noção","\\bobjetos\\b" = "objeto", "\\bocasionado\\b" = "ocasionar",
        "\\bocasionaram\\b" = "ocasionar", "\\boficiais\\b" = "oficial","\\boitivas\\b" = "oitiva", "\\boperada\\b" = "operar", "\\boperado\\b" = "operar",
        "\\boperou\\b" = "operar","\\boportunidades\\b" = "oportunidade", "\\borganizadas\\b" = "organização",
        "\\borganizado\\b" = "organização", "\\borganizaram\\b" = "organizar", "\\borganizem\\b" = "organizar","\\borganizou\\b" = "organizar",
        "\\borganizações\\b" = "organização", "\\borientações\\b" = "orientação","\\bpacíficas\\b" = "pacífico", "\\bpacíficos\\b" = "pacífico",
        "\\bpalavras\\b" = "palavra","\\bpalácios\\b" = "palácio", "\\bpautas\\b" = "pauta","\\bpaíses\\b" = "país", "\\bpensamentos\\b" = "pensamento",
        "\\bperfis\\b" = "perfil","\\bpericiais\\b" = "pericial","\\bpermanece\\b" = "permanecer", "\\bpermanencendo\\b" = "permanecer",
        "\\bpermaneceram\\b" = "permanecer","\\bpermaneceria\\b" = "permanecer","\\bpermaneceriam\\b" = "permanecer", "\\bpermaneceu\\b" = "permanecer",
        "\\bpermaneciam\\b" = "permanecer", "\\bperpetradas\\b" = "perpetrar", "\\bperpetrada\\b" = "perpetrar",
        "\\bpessoais\\b" = "pessoal","\\bpessoas\\b" = "pessoa", "\\bplanos\\b" = "plano","\\bpleiteando\\b" = "pleitear", 
        "\\bpleiteava\\b" = "pleitear", "\\bpleiteavam\\b" = "pleitear", "\\bpleiteia\\b" = "pleitear", "\\bpleiteou\\b" = "pleitear",
        "\\bpluralista\\b" = "pluralismo","\\bplásticas\\b" = "plástico", "\\bpopulares\\b" = "popular", "\\bportava\\b" = "portar",
        "\\bportavam\\b" = "portar", "\\bposicionamentos\\b" = "posicionamento", "\\bpossibilitem\\b" = "possibilitar", "\\bpotenciais\\b" = "potencial",
        "\\bpraticadas\\b" = "praticado","\\bpraticando\\b" = "praticar", "\\bpraticaram\\b" = "praticar", "\\bpraticou\\b" = "praticar",
        "\\bprecisam\\b" = "precisar","\\bprecisava\\b" = "precisar","\\bprejuízos\\b" = "prejuízo", "\\bprerrogativas\\b" = "prerrogativa",
        "\\bprescinde\\b" = "prescindir","\\bpresidenciais\\b" = "presidencial", "\\bpressupostos\\b" = "pressuposto", "\\bprestadas\\b" = "prestar",
        "\\bprestado\\b" = "prestar", "\\bprestados\\b" = "prestar","\\bprestaram\\b" = "prestar", "\\bpretendam\\b" = "pretender",
        "\\bpretende\\b" = "pretender","\\bpretendem\\b" = "pretender", "\\bpretendiam\\b" = "pretender", "\\bpretendidos\\b" = "pretendido",
        "\\bprisões\\b" = "prisão","\\bprobatória\\b" = "probatório", "\\bprobatórias\\b" = "probatório", "\\bprobatórios\\b" = "probatório",
        "\\bprocedimentais\\b" = "procedimento","\\bprocedimentos\\b" = "procedimento", "\\bprocessuais\\b" = "processual", "\\bprofere\\b" = "proferir",
        "\\bproferiam\\b" = "proferir","\\bproferida\\b" = "proferido","\\bproferidas\\b" = "proferido", "\\bproferidos\\b" = "proferido",
        "\\bproferindo\\b" = "proferir", "\\bpromoveram\\b" = "promover","\\bpromovessem\\b" = "promover", "\\bpropósitos\\b" = "propósito",
        "\\bprotestos\\b" = "protesto","\\bprovocaram\\b" = "provocar", "\\bpráticas\\b" = "prática", "\\bprédios\\b" = "prédio",
        "\\bpsicológica\\b" = "psicológico", "\\bpsicológicos\\b" = "psicológico", "\\bpuníveis\\b" = "punível", "\\bpúblicas\\b" = "pública")
    )
  )

#LETRAS Q, R, S

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\bqualificadoras\\b" = "qualificadora", "\\bquantitativa\\b" = "quantitativo", "\\bquantitativos\\b" = "quantitativo",
        "\\bquartéis\\b" = "quartel","\\bquebrados\\b" = "quebrado", "\\bquebramos\\b" = "quebrar", "\\bquebrando\\b" = "quebrar",
        "\\bquebrassem\\b" = "quebrar", "\\bquebrou\\b" = "quebrar", "\\brazoáveis\\b" = "razoável", "\\breais\\b" = "real",
        "\\brecebidas\\b" = "recebimento", "\\brecebido\\b" = "recebimento", "\\brecuou\\b" = "recuar","\\brecuaram\\b" = "recuar",
        "\\bredes\\b" = "rede","\\breferentes\\b" = "referente", "\\breferida\\b" = "referido", "\\breferidas\\b" = "referido",
        "\\breferidos\\b" = "referido", "\\bregimes\\b" = "regime", "\\bregistrada\\b" = "registrar", "\\bregistradas\\b" = "registrar",
        "\\bregistraram\\b" = "registrar","\\bregistre\\b" = "registrar", "\\bregistrando\\b" = "registrar", "\\bregistrou\\b" = "registrar",
        "\\brelativa\\b" = "relativo","\\brelativas\\b" = "relativo","\\brelativos\\b" = "relativo", "\\brelata\\b" = "relatar",
        "\\brelatou\\b" = "relatar","\\brelatado\\b" = "relatar", "\\brelataram\\b" = "relatar", "\\brelevantes\\b" = "relevante",
        "\\brememoro\\b" = "rememorar", "\\bremetido\\b" = "remeter", "\\bremetidos\\b" = "remeter", "\\bremetem\\b" = "remeter",
        "\\brepetidas\\b" = "repetir","\\brepetindo\\b" = "repetir", "\\breportada\\b" = "reportado","\\breportados\\b" = "reportado",
        "\\breporta\\b" = "reportar","\\breportam\\b" = "reportar", "\\brepresenta\\b" = "representar", "\\brepresentam\\b" = "representar",
        "\\brepresentativas\\b" = "representativo","\\brepresentações\\b" = "representação", "\\breprimendas\\b" = "reprimenda",
        "\\bresponderão\\b" = "responder","\\bresponsáveis\\b" = "responsável", "\\bressaltado\\b" = "ressaltar", "\\bressaltando\\b" = "ressaltar",
        "\\brestando\\b" = "restar","\\brestaram\\b" = "restar", "\\brestou\\b" = "restar", "\\brestringindo\\b" = "restringir",
        "\\brestritivas\\b" = "restritiva", "\\bresultados\\b" = "resultado", "\\bresultando\\b" = "resultar", "\\bresultaram\\b" = "resultar",
        "\\bresultou\\b" = "resultar", "\\bresultantes\\b" = "resultante", "\\bretomada\\b" = "retomado", "\\bretomados\\b" = "retomado",
        "\\bretomo\\b" = "retomar", "\\bretomou\\b" = "retomar", "\\brevela\\b" = "revelar","\\brevelam\\b" = "revelar", "\\brevelou\\b" = "revelar",
        "\\breúne\\b" = "reunir","\\breúnem\\b" = "reunir", "\\briscos\\b" = "risco", "\\brompendo\\b" = "romper","\\bromperam\\b" = "romper",
        "\\brompida\\b" = "rompido","\\brompidas\\b" = "rompido", "\\brádios\\b" = "rádio", "\\bsabia\\b" = "saber","\\bsabiam\\b" = "saber",
        "\\bsabendo\\b" = "saber","\\bsaiba\\b" = "saber", "\\bsairiam\\b" = "sair","\\bsaiu\\b" = "sair", "\\bsaíram\\b" = "sair",
        "\\bsaíssem\\b" = "sair", "\\bsalas\\b" = "sala", "\\bsalienta\\b" = "salientar","\\bsalientando\\b" = "salientar", "\\bsaliento\\b" = "salientar",
        "\\bsanções\\b" = "sanção", "\\bsegmentos\\b" = "segmento", "\\bseguiram\\b" = "seguir", "\\bseguiu\\b" = "seguir", "\\bselfies\\b" = "selfie",
        "\\bsemelhantes\\b" = "semelhante","\\bsentadas\\b" = "sentado", "\\bsentados\\b" = "sentado", "\\bserviços\\b" = "serviço",
        "\\bsetores\\b" = "setor","\\bsignificativa\\b" = "significativo", "\\bsignificativos\\b" = "significativo", "\\bsituações\\b" = "situação",
        "\\bsociais\\b" = "social","\\bsolicitado\\b" = "solicitar", "\\bsolicitando\\b" = "solicitar", "\\bsolidária\\b" = "solidariedade",
        "\\bsomados\\b" = "soma","\\bsomatória\\b" = "soma", "\\bsomando\\b" = "soma", "\\bsubiu\\b" = "subir", "\\bsubindo\\b" = "subir",
        "\\bsubjetivas\\b" = "subjetiva", "\\bsubmetidas\\b" = "submetido", "\\bsubmetidos\\b" = "submetido", "\\bsuficientes\\b" = "suficiente",
        "\\bsufoca\\b" = "sufocar","\\bsufocavam\\b" = "sufocar", "\\bsuposta\\b" = "suposição","\\bsupostas\\b" = "suposição",
        "\\bsuposto\\b" = "suposição", "\\bsustentada\\b" = "sustentação", "\\bsustentado\\b" = "sustentação", "\\bsustenta\\b" = "sustentar",
        "\\bsustentando\\b" = "sustentou", "\\bsustentações\\b" = "sustentação")
    )
  )


#LETRA T EM DIANTE

votos_unnested<-votos_unnested %>%
  mutate(
    word = str_replace_all(
      word,
      c("\\btelefones\\b" = "telefone", "\\btemas\\b" = "tema", "\\btentam\\b" = "tentar", "\\btentando\\b" = "tentar", "\\btentava\\b" = "tentar",
        "\\btentou\\b" = "tentar", "\\bterritórios\\b" = "território", "\\bteses\\b" = "tese", "\\btextos\\b" = "texto", "\\btipificada\\b" = "tipificado",
        "\\btipificadas\\b" = "tipificado", "\\btipificados\\b" = "tipificado", "\\btipos\\b" = "tipo", "\\btiros\\b" = "tiro","\\btitular\\b" = "titularidade",
        "\\btitulares\\b" = "titularidade", "\\btoma\\b" = "tomar","\\btomamos\\b" = "tomar","\\btomando\\b" = "tomar", "\\btomarem\\b" = "tomar",
        "\\btomou\\b" = "tomar", "\\btorna\\b" = "tornar", "\\btramitam\\b" = "tramitar", "\\btramitou\\b" = "tramitar", "\\btranscrita\\b" = "transcrição",
        "\\btranscrições\\b" = "transcrição", "\\btransforma\\b" = "transformar", "\\btransmissões\\b" = "transmissão", "\\btrazem\\b" = "trazer",
        "\\btraz\\b" = "trazer","\\btrazidas\\b" = "trazer", "\\btrazido\\b" = "trazer", "\\btrazidos\\b" = "trazer", "\\btropas\\b" = "tropa",
        "\\btumultuária\\b" = "tumulto", "\\btumultuário\\b" = "tumulto", "\\btutelado\\b" = "tutelar", "\\btutelam\\b" = "tutelar", "\\btípicos\\b" = "típico",
        "\\btópicos\\b" = "tópico", "\\bultrapassam\\b" = "ultrapassar","\\bultrapassa\\b" = "ultrapassar", "\\bunidades\\b" = "unidade", "\\bunido\\b" = "unir",
        "\\buniram\\b" = "unir","\\buniu\\b" = "unir", "\\burbana\\b" = "urbano", "\\busaram\\b" = "usar","\\busavam\\b" = "usar", "\\busou\\b" = "usar",
        "\\busava\\b" = "usar","\\busaria\\b" = "usar", "\\butilizada\\b" = "utilizado", "\\butilizadas\\b" = "utilizado",
        "\\butilizam\\b" = "utilizar","\\butilizando\\b" = "utilizar", "\\butilizavam\\b" = "utilizar", "\\butilizaram\\b" = "utilizar",
        "\\bvagabundos\\b" = "vagabundo","\\bvalores\\b" = "valor", "\\bvandaliza\\b" = "vandalizar", "\\bvandalizavam\\b" = "vandalizar", 
        "\\bvandalizou\\b" = "vandalizar", "\\bvariava\\b" = "variar", "\\bvejam\\b" = "ver", "\\bverdadeiros\\b" = "verdadeiro", "\\bverdadeiras\\b" = "verdadeiro",
        "\\bverificadas\\b" = "verificação", "\\bverificada\\b" = "verificação", "\\bverificados\\b" = "verificação", "\\bverificado\\b" = "verificação",
        "\\bverificou\\b" = "verificar", "\\bvetoriais\\b" = "vetores", "\\bveículos\\b" = "veículo", "\\bviabilizou\\b" = "viabilizar", "\\bvidros\\b" = "vidro",
        "\\bvieram\\b" = "vir", "\\bvincula\\b" = "vincular", "\\bvinculem\\b" = "vincular", "\\bvinculada\\b" = "vinculação", "\\bvoltados\\b" = "voltado",
        "\\bvontades\\b" = "vontade", "\\bvotou\\b" = "votar","\\bvícios\\b" = "vício", "\\bvítimas\\b" = "vítima", "\\báudios\\b" = "áudio")
    )
  )


#====FINAL TOKEN DATASET====

#Storing the results of previous operations 

writexl::write_xlsx(votos_unnested, path="votos_tokens.xlsx",
                    col_names=T)


