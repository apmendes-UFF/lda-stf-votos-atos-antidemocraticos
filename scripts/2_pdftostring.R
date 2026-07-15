#== SCRIPT DE EXTRAÇÃO DOS VOTOS PARA TXT ==#

library(pdftools)

#====COLETA 1 ====

############Bloco 1
v1057_ext<-pdf_text("Votos Relator/voto_1057.pdf")
v1058_ext<-pdf_text("Votos Relator/voto_1058.pdf")
v1060_ext<-pdf_text("Votos Relator/voto_1060.pdf")
v1066_ext<-pdf_text("Votos Relator/voto_1066.pdf")
v1071_ext<-pdf_text("Votos Relator/voto_1071.pdf")
v1075_ext<-pdf_text("Votos Relator/voto_1075.pdf")
v1077_ext<-pdf_text("Votos Relator/voto_1077.pdf")
v1105_ext<-pdf_text("Votos Relator/voto_1105.pdf")
v1109_ext<-pdf_text("Votos Relator/voto_1109.pdf")

#Colapsando para ficar em uma string só
v1057_unico <- paste(v1057_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1058_unico <- paste(v1058_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1060_unico <- paste(v1060_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1066_unico <- paste(v1066_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1071_unico <- paste(v1071_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1075_unico <- paste(v1075_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1077_unico <- paste(v1077_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1105_unico <- paste(v1105_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v1109_unico <- paste(v1109_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1057_unico, "voto1057_extraido.txt")
writeLines(v1058_unico, "voto1058_extraido.txt")
writeLines(v1060_unico, "voto1060_extraido.txt")
writeLines(v1066_unico, "voto1066_extraido.txt")
writeLines(v1071_unico, "voto1071_extraido.txt")
writeLines(v1075_unico, "voto1075_extraido.txt")
writeLines(v1077_unico, "voto1077_extraido.txt")
writeLines(v1105_unico, "voto1105_extraido.txt")
writeLines(v1109_unico, "voto1109_extraido.txt")

############Bloco 2
v1112_ext<-pdf_text("Votos Relator/voto_1112.pdf")
v1113_ext<-pdf_text("Votos Relator/voto_1113.pdf")
v1116_ext<-pdf_text("Votos Relator/voto_1116.pdf")
v1125_ext<-pdf_text("Votos Relator/voto_1125.pdf")
v1130_ext<-pdf_text("Votos Relator/voto_1130.pdf")
v1133_ext<-pdf_text("Votos Relator/voto_1133.pdf")
v1147_ext<-pdf_text("Votos Relator/voto_1147.pdf")
v1153_ext<-pdf_text("Votos Relator/voto_1153.pdf")
v1156_ext<-pdf_text("Votos Relator/voto_1156.pdf")

#Colapsando para ficar em uma string só
v1112_unico <- paste(v1112_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1113_unico <- paste(v1113_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1116_unico <- paste(v1116_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1125_unico <- paste(v1125_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1130_unico <- paste(v1130_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1133_unico <- paste(v1133_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1147_unico <- paste(v1147_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1153_unico <- paste(v1153_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1156_unico <- paste(v1156_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1112_unico, "voto1112_extraido.txt")
writeLines(v1113_unico, "voto1113_extraido.txt")
writeLines(v1116_unico, "voto1116_extraido.txt")
writeLines(v1125_unico, "voto1125_extraido.txt")
writeLines(v1130_unico, "voto1130_extraido.txt")
writeLines(v1133_unico, "voto1133_extraido.txt")
writeLines(v1147_unico, "voto1147_extraido.txt")
writeLines(v1153_unico, "voto1153_extraido.txt")
writeLines(v1156_unico, "voto1156_extraido.txt")

############Bloco 3
v1163_ext<-pdf_text("Votos Relator/voto_1163.pdf")
v1173_ext<-pdf_text("Votos Relator/voto_1173.pdf")
v1176_ext<-pdf_text("Votos Relator/voto_1176.pdf")
v1177_ext<-pdf_text("Votos Relator/voto_1177.pdf")
v1178_ext<-pdf_text("Votos Relator/voto_1178.pdf")
v1179_ext<-pdf_text("Votos Relator/voto_1179.pdf")
v1180_ext<-pdf_text("Votos Relator/voto_1180.pdf")
v1183_ext<-pdf_text("Votos Relator/voto_1183.pdf")
v1184_ext<-pdf_text("Votos Relator/voto_1184.pdf")

#Colapsando para ficar em uma string só
v1163_unico <- paste(v1163_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1173_unico <- paste(v1173_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1176_unico <- paste(v1176_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1177_unico <- paste(v1177_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1178_unico <- paste(v1178_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1179_unico <- paste(v1179_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1180_unico <- paste(v1180_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1183_unico <- paste(v1183_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1184_unico <- paste(v1184_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1163_unico, "voto1163_extraido.txt")
writeLines(v1173_unico, "voto1173_extraido.txt")
writeLines(v1176_unico, "voto1176_extraido.txt")
writeLines(v1177_unico, "voto1177_extraido.txt")
writeLines(v1178_unico, "voto1178_extraido.txt")
writeLines(v1179_unico, "voto1179_extraido.txt")
writeLines(v1180_unico, "voto1180_extraido.txt")
writeLines(v1183_unico, "voto1183_extraido.txt")
writeLines(v1184_unico, "voto1184_extraido.txt")

############Bloco 4
v1194_ext<-pdf_text("Votos Relator/voto_1194.pdf")
v1228_ext<-pdf_text("Votos Relator/voto_1228.pdf")
v1250_ext<-pdf_text("Votos Relator/voto_1250.pdf")
v1268_ext<-pdf_text("Votos Relator/voto_1268.pdf")
v1269_ext<-pdf_text("Votos Relator/voto_1269.pdf")
v1285_ext<-pdf_text("Votos Relator/voto_1285.pdf")
v1296_ext<-pdf_text("Votos Relator/voto_1296.pdf")
v1314_ext<-pdf_text("Votos Relator/voto_1314.pdf")
v1359_ext<-pdf_text("Votos Relator/voto_1359.pdf")

#Colapsando para ficar em uma string só
v1194_unico <- paste(v1194_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1228_unico <- paste(v1228_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1250_unico <- paste(v1250_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1268_unico <- paste(v1268_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1269_unico <- paste(v1269_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1285_unico <- paste(v1285_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1296_unico <- paste(v1296_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1314_unico <- paste(v1314_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1359_unico <- paste(v1359_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1194_unico, "voto1194_extraido.txt")
writeLines(v1228_unico, "voto1228_extraido.txt")
writeLines(v1250_unico, "voto1250_extraido.txt")
writeLines(v1268_unico, "voto1268_extraido.txt")
writeLines(v1269_unico, "voto1269_extraido.txt")
writeLines(v1285_unico, "voto1285_extraido.txt")
writeLines(v1296_unico, "voto1296_extraido.txt")
writeLines(v1314_unico, "voto1314_extraido.txt")
writeLines(v1359_unico, "voto1359_extraido.txt")


############Bloco 5
v1373_ext<-pdf_text("Votos Relator/voto_1373.pdf")
v1380_ext<-pdf_text("Votos Relator/voto_1380.pdf")
v1381_ext<-pdf_text("Votos Relator/voto_1381.pdf")
v1388_ext<-pdf_text("Votos Relator/voto_1388.pdf")
v1391_ext<-pdf_text("Votos Relator/voto_1391.pdf")
v1403_ext<-pdf_text("Votos Relator/voto_1403.pdf")
v1405_ext<-pdf_text("Votos Relator/voto_1405.pdf")
v1413_ext<-pdf_text("Votos Relator/voto_1413.pdf")
v1416_ext<-pdf_text("Votos Relator/voto_1416.pdf")

#Colapsando para ficar em uma string só
v1373_unico <- paste(v1373_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1380_unico <- paste(v1380_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1381_unico <- paste(v1381_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1388_unico <- paste(v1388_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1391_unico <- paste(v1391_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1403_unico <- paste(v1403_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1405_unico <- paste(v1405_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1413_unico <- paste(v1413_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1416_unico <- paste(v1416_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1373_unico, "voto1373_extraido.txt")
writeLines(v1380_unico, "voto1380_extraido.txt")
writeLines(v1381_unico, "voto1381_extraido.txt")
writeLines(v1388_unico, "voto1388_extraido.txt")
writeLines(v1391_unico, "voto1391_extraido.txt")
writeLines(v1403_unico, "voto1403_extraido.txt")
writeLines(v1405_unico, "voto1405_extraido.txt")
writeLines(v1413_unico, "voto1413_extraido.txt")
writeLines(v1416_unico, "voto1416_extraido.txt")


############Bloco 6
v1419_ext<-pdf_text("Votos Relator/voto_1419.pdf")
v1421_ext<-pdf_text("Votos Relator/voto_1421.pdf")
v1422_ext<-pdf_text("Votos Relator/voto_1422.pdf")
v1423_ext<-pdf_text("Votos Relator/voto_1423.pdf")
v1427_ext<-pdf_text("Votos Relator/voto_1427.pdf")
v1429_ext<-pdf_text("Votos Relator/voto_1429.pdf")
v1432_ext<-pdf_text("Votos Relator/voto_1432.pdf")
v1473_ext<-pdf_text("Votos Relator/voto_1473.pdf")
v1488_ext<-pdf_text("Votos Relator/voto_1488.pdf")

#Colapsando para ficar em uma string só
v1419_unico <- paste(v1419_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1421_unico <- paste(v1421_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1422_unico <- paste(v1422_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1423_unico <- paste(v1423_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1427_unico <- paste(v1427_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1429_unico <- paste(v1429_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1432_unico <- paste(v1432_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1473_unico <- paste(v1473_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1488_unico <- paste(v1488_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1419_unico, "voto1419_extraido.txt")
writeLines(v1421_unico, "voto1421_extraido.txt")
writeLines(v1422_unico, "voto1423_extraido.txt")
writeLines(v1423_unico, "voto1423_extraido.txt")
writeLines(v1427_unico, "voto1427_extraido.txt")
writeLines(v1429_unico, "voto1429_extraido.txt")
writeLines(v1432_unico, "voto1432_extraido.txt")
writeLines(v1473_unico, "voto1473_extraido.txt")
writeLines(v1488_unico, "voto1488_extraido.txt")


############Bloco 7
v1492_ext<-pdf_text("Votos Relator/voto_1492.pdf")
v1498_ext<-pdf_text("Votos Relator/voto_1498.pdf")
v1499_ext<-pdf_text("Votos Relator/voto_1499.pdf")
v1502_ext<-pdf_text("Votos Relator/voto_1502.pdf")
v1503_ext<-pdf_text("Votos Relator/voto_1503.pdf")
v1512_ext<-pdf_text("Votos Relator/voto_1512.pdf")
v1517_ext<-pdf_text("Votos Relator/voto_1517.pdf")
v1545_ext<-pdf_text("Votos Relator/voto_1545.pdf")
v1550_ext<-pdf_text("Votos Relator/voto_1550.pdf")

#Colapsando para ficar em uma string só
v1492_unico <- paste(v1492_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1498_unico <- paste(v1498_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1499_unico <- paste(v1499_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1502_unico <- paste(v1502_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1503_unico <- paste(v1503_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1512_unico <- paste(v1512_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1517_unico <- paste(v1517_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1545_unico <- paste(v1545_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1550_unico <- paste(v1550_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1492_unico, "voto1492_extraido.txt")
writeLines(v1498_unico, "voto1498_extraido.txt")
writeLines(v1499_unico, "voto1499_extraido.txt")
writeLines(v1502_unico, "voto1502_extraido.txt")
writeLines(v1503_unico, "voto1503_extraido.txt")
writeLines(v1512_unico, "voto1512_extraido.txt")
writeLines(v1517_unico, "voto1517_extraido.txt")
writeLines(v1545_unico, "voto1545_extraido.txt")
writeLines(v1550_unico, "voto1550_extraido.txt")

############Bloco 8
v1575_ext<-pdf_text("Votos Relator/voto_1575.pdf")
v1670_ext<-pdf_text("Votos Relator/voto_1670.pdf")
v1720_ext<-pdf_text("Votos Relator/voto_1720.pdf")
v1740_ext<-pdf_text("Votos Relator/voto_1740.pdf")
v1743_ext<-pdf_text("Votos Relator/voto_1743.pdf")
v1764_ext<-pdf_text("Votos Relator/voto_1764.pdf")
v1773_ext<-pdf_text("Votos Relator/voto_1773.pdf")
v1780_ext<-pdf_text("Votos Relator/voto_1780.pdf")
v2085_ext<-pdf_text("Votos Relator/voto_2085.pdf")

#Colapsando para ficar em uma string só
v1575_unico <- paste(v1575_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1670_unico <- paste(v1670_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1720_unico <- paste(v1720_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1740_unico <- paste(v1740_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1743_unico <- paste(v1743_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1764_unico <- paste(v1764_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1773_unico <- paste(v1773_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1780_unico <- paste(v1780_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2085_unico <- paste(v2085_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1575_unico, "voto1575_extraido.txt")
writeLines(v1670_unico, "voto1670_extraido.txt")
writeLines(v1720_unico, "voto1720_extraido.txt")
writeLines(v1740_unico, "voto1740_extraido.txt")
writeLines(v1743_unico, "voto1743_extraido.txt")
writeLines(v1764_unico, "voto1764_extraido.txt")
writeLines(v1773_unico, "voto1773_extraido.txt")
writeLines(v1780_unico, "voto1780_extraido.txt")
writeLines(v2085_unico, "voto2085_extraido.txt")

############Bloco 9

v2087_ext<-pdf_text("Votos Relator/voto_2087.pdf")
v2326_ext<-pdf_text("Votos Relator/voto_2326.pdf")
v2330_ext<-pdf_text("Votos Relator/voto_2330.pdf")
v2337_ext<-pdf_text("Votos Relator/voto_2337.pdf")
v2442_ext<-pdf_text("Votos Relator/voto_2442.pdf")
v2468_ext<-pdf_text("Votos Relator/voto_2468.pdf")
v2472_ext<-pdf_text("Votos Relator/voto_2472.pdf")
v2540_ext<-pdf_text("Votos Relator/voto_2540.pdf")


#Colapsando para ficar em uma string só
v2087_unico <- paste(v2087_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2326_unico <- paste(v2326_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2330_unico <- paste(v2330_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2337_unico <- paste(v2337_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2442_unico <- paste(v2442_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2468_unico <- paste(v2468_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2472_unico <- paste(v2472_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2540_unico <- paste(v2540_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v2087_unico, "voto2087_extraido.txt")
writeLines(v2326_unico, "voto2326_extraido.txt")
writeLines(v2330_unico, "voto2330_extraido.txt")
writeLines(v2337_unico, "voto2337_extraido.txt")
writeLines(v2442_unico, "voto2442_extraido.txt")
writeLines(v2468_unico, "voto2468_extraido.txt")
writeLines(v2472_unico, "voto2472_extraido.txt")
writeLines(v2540_unico, "voto2540_extraido.txt")

####Adicional
library(pdftools)
v1193_ext<-pdf_text("Votos Relator/voto_1193.pdf")
v1194_ext<-pdf_text("Votos Relator/voto_1194.pdf")

v1193_unico <- paste(v1193_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1194_unico <- paste(v1194_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo

writeLines(v1193_unico, "voto1193_extraido.txt")
writeLines(v1194_unico, "voto1194_extraido.txt")


#####Adicional 2

library(pdftools)
pdf_subset("Ações Penais - Acórdãos - Coleta 1/1123.pdf", pages = c(15:141), output = "voto_1123.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 1/1190.pdf", pages = c(25:132), output = "voto_1190.pdf")

v1123_ext<-pdf_text("Votos Relator/voto_1123.pdf")
v1190_ext<-pdf_text("Votos Relator/voto_1190.pdf")

v1123_unico <- paste(v1123_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1190_unico <- paste(v1190_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1123_unico, "voto1123_extraido.txt")
writeLines(v1190_unico, "voto1190_extraido.txt")


v1422_ext<-pdf_text("Votos Relator/voto_1422.pdf")

v1422_unico <- paste(v1422_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

writeLines(v1422_unico, "voto1422_extraido.txt")


#====COLETA 2====

####BLOCO 10

v1096_ext<-pdf_text("Votos Relator/voto_1096.pdf")
v1103_ext<-pdf_text("Votos Relator/voto_1103.pdf")
v1224_ext<-pdf_text("Votos Relator/voto_1224.pdf")
v1337_ext<-pdf_text("Votos Relator/voto_1337.pdf")
v1464_ext<-pdf_text("Votos Relator/voto_1464.pdf")
v1468_ext<-pdf_text("Votos Relator/voto_1468.pdf")
v1521_ext<-pdf_text("Votos Relator/voto_1521.pdf")
v1548_ext<-pdf_text("Votos Relator/voto_1548.pdf")


#Colapsando para ficar em uma string só
v1096_unico <- paste(v1096_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1103_unico <- paste(v1103_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1224_unico <- paste(v1224_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1337_unico <- paste(v1337_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1464_unico <- paste(v1464_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1468_unico <- paste(v1464_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1521_unico <- paste(v1521_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1548_unico <- paste(v1548_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v1096_unico, "voto1096_extraido.txt")
writeLines(v1103_unico, "voto1103_extraido.txt")
writeLines(v1224_unico, "voto1224_extraido.txt")
writeLines(v1337_unico, "voto1337_extraido.txt")
writeLines(v1464_unico, "voto1464_extraido.txt")
writeLines(v1468_unico, "voto1468_extraido.txt")
writeLines(v1521_unico, "voto1521_extraido.txt")
writeLines(v1548_unico, "voto1548_extraido.txt")


#####BLOCO 11

v1096_ext<-pdf_text("Votos Relator/voto_1096.pdf")
v1103_ext<-pdf_text("Votos Relator/voto_1103.pdf")
v1224_ext<-pdf_text("Votos Relator/voto_1224.pdf")
v1337_ext<-pdf_text("Votos Relator/voto_1337.pdf")
v1464_ext<-pdf_text("Votos Relator/voto_1464.pdf")
v1468_ext<-pdf_text("Votos Relator/voto_1468.pdf")
v1521_ext<-pdf_text("Votos Relator/voto_1521.pdf")
v1548_ext<-pdf_text("Votos Relator/voto_1548.pdf")


#Colapsando para ficar em uma string só
v1096_unico <- paste(v1096_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1103_unico <- paste(v1103_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1224_unico <- paste(v1224_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1337_unico <- paste(v1337_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1464_unico <- paste(v1464_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1468_unico <- paste(v1464_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1521_unico <- paste(v1521_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1548_unico <- paste(v1548_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v1096_unico, "voto1096_extraido.txt")
writeLines(v1103_unico, "voto1103_extraido.txt")
writeLines(v1224_unico, "voto1224_extraido.txt")
writeLines(v1337_unico, "voto1337_extraido.txt")
writeLines(v1464_unico, "voto1464_extraido.txt")
writeLines(v1468_unico, "voto1468_extraido.txt")
writeLines(v1521_unico, "voto1521_extraido.txt")
writeLines(v1548_unico, "voto1548_extraido.txt")

#######BLOCO 12

v1629_ext<-pdf_text("Votos Relator/voto_1629.pdf")
v1573_ext<-pdf_text("Votos Relator/voto_1573.pdf")
v1735_ext<-pdf_text("Votos Relator/voto_1735.pdf")
v1705_ext<-pdf_text("Votos Relator/voto_1705.pdf")
v1642_ext<-pdf_text("Votos Relator/voto_1642.pdf")
v1789_ext<-pdf_text("Votos Relator/voto_1789.pdf")
v1786_ext<-pdf_text("Votos Relator/voto_1786.pdf")
v1842_ext<-pdf_text("Votos Relator/voto_1842.pdf")


#Colapsando para ficar em uma string só
v1629_unico <- paste(v1629_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1573_unico <- paste(v1573_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1735_unico <- paste(v1735_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1705_unico <- paste(v1705_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1642_unico <- paste(v1642_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1789_unico <- paste(v1789_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1786_unico <- paste(v1786_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1842_unico <- paste(v1842_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v1629_unico, "voto1629_extraido.txt")
writeLines(v1573_unico, "voto1573_extraido.txt")
writeLines(v1735_unico, "voto1735_extraido.txt")
writeLines(v1705_unico, "voto1705_extraido.txt")
writeLines(v1642_unico, "voto1642_extraido.txt")
writeLines(v1789_unico, "voto1789_extraido.txt")
writeLines(v1786_unico, "voto1786_extraido.txt")
writeLines(v1842_unico, "voto1842_extraido.txt")

#########BLOCO 13

v1818_ext<-pdf_text("Votos Relator/voto_1818.pdf")
v1792_ext<-pdf_text("Votos Relator/voto_1792.pdf")
v2006_ext<-pdf_text("Votos Relator/voto_2006.pdf")
v1970_ext<-pdf_text("Votos Relator/voto_1970.pdf")
v1858_ext<-pdf_text("Votos Relator/voto_1858.pdf")
v1857_ext<-pdf_text("Votos Relator/voto_1857.pdf")
v1935_ext<-pdf_text("Votos Relator/voto_1935.pdf")
v2023_ext<-pdf_text("Votos Relator/voto_2023.pdf")


#Colapsando para ficar em uma string só
v1818_unico <- paste(v1818_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1792_unico <- paste(v1792_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2006_unico <- paste(v2006_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1970_unico <- paste(v1970_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1858_unico <- paste(v1858_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1857_unico <- paste(v1857_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1935_unico <- paste(v1935_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2023_unico <- paste(v2023_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v1818_unico, "voto1818_extraido.txt")
writeLines(v1792_unico, "voto1792_extraido.txt")
writeLines(v2006_unico, "voto2006_extraido.txt")
writeLines(v1970_unico, "voto1970_extraido.txt")
writeLines(v1858_unico, "voto1858_extraido.txt")
writeLines(v1857_unico, "voto1857_extraido.txt")
writeLines(v1935_unico, "voto1935_extraido.txt")
writeLines(v2023_unico, "voto2023_extraido.txt")


################BLOCO 14

v2015_ext<-pdf_text("Votos Relator/voto_2015.pdf")
v2061_ext<-pdf_text("Votos Relator/voto_2061.pdf")
v2057_ext<-pdf_text("Votos Relator/voto_2057.pdf")
v2111_ext<-pdf_text("Votos Relator/voto_2111.pdf")
v2080_ext<-pdf_text("Votos Relator/voto_2080.pdf")
v2139_ext<-pdf_text("Votos Relator/voto_2139.pdf")
v2137_ext<-pdf_text("Votos Relator/voto_2137.pdf")
v2130_ext<-pdf_text("Votos Relator/voto_2130.pdf")


#Colapsando para ficar em uma string só
v2015_unico <- paste(v2015_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2061_unico <- paste(v2061_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2057_unico <- paste(v2057_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2111_unico <- paste(v2111_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2080_unico <- paste(v2080_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2139_unico <- paste(v2139_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2137_unico <- paste(v2137_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2130_unico <- paste(v2130_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v2015_unico, "voto2015_extraido.txt")
writeLines(v2061_unico, "voto2061_extraido.txt")
writeLines(v2057_unico, "voto2057_extraido.txt")
writeLines(v2111_unico, "voto2111_extraido.txt")
writeLines(v2080_unico, "voto2080_extraido.txt")
writeLines(v2139_unico, "voto2139_extraido.txt")
writeLines(v2137_unico, "voto2137_extraido.txt")
writeLines(v2130_unico, "voto2130_extraido.txt")

###########BLOCO 15

v2162_ext<-pdf_text("Votos Relator/voto_2162.pdf")
v2157_ext<-pdf_text("Votos Relator/voto_2157.pdf")
v2150_ext<-pdf_text("Votos Relator/voto_2150.pdf")
v2148_ext<-pdf_text("Votos Relator/voto_2148.pdf")
v2144_ext<-pdf_text("Votos Relator/voto_2144.pdf")
v2245_ext<-pdf_text("Votos Relator/voto_2245.pdf")
v2219_ext<-pdf_text("Votos Relator/voto_2219.pdf")
v2187_ext<-pdf_text("Votos Relator/voto_2187.pdf")


#Colapsando para ficar em uma string só
v2162_unico <- paste(v2162_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2157_unico <- paste(v2157_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2150_unico <- paste(v2150_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2148_unico <- paste(v2148_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2144_unico <- paste(v2144_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2245_unico <- paste(v2245_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2219_unico <- paste(v2219_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2187_unico <- paste(v2187_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v2162_unico, "voto2162_extraido.txt")
writeLines(v2157_unico, "voto2157_extraido.txt")
writeLines(v2150_unico, "voto2150_extraido.txt")
writeLines(v2148_unico, "voto2148_extraido.txt")
writeLines(v2144_unico, "voto2144_extraido.txt")
writeLines(v2245_unico, "voto2245_extraido.txt")
writeLines(v2219_unico, "voto2219_extraido.txt")
writeLines(v2187_unico, "voto2187_extraido.txt")

###########BLOCO 16####

v2175_ext<-pdf_text("Votos Relator/voto_2175.pdf")
v2174_ext<-pdf_text("Votos Relator/voto_2174.pdf")
v2320_ext<-pdf_text("Votos Relator/voto_2320.pdf")
v2315_ext<-pdf_text("Votos Relator/voto_2315.pdf")
v2287_ext<-pdf_text("Votos Relator/voto_2287.pdf")
v2285_ext<-pdf_text("Votos Relator/voto_2285.pdf")
v2276_ext<-pdf_text("Votos Relator/voto_2276.pdf")
v2387_ext<-pdf_text("Votos Relator/voto_2387.pdf")


#Colapsando para ficar em uma string só
v2175_unico <- paste(v2175_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2174_unico <- paste(v2174_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2320_unico <- paste(v2320_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2315_unico <- paste(v2315_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2287_unico <- paste(v2287_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2285_unico <- paste(v2285_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2276_unico <- paste(v2276_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2387_unico <- paste(v2387_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v2175_unico, "voto2175_extraido.txt")
writeLines(v2174_unico, "voto2174_extraido.txt")
writeLines(v2320_unico, "voto2320_extraido.txt")
writeLines(v2315_unico, "voto2315_extraido.txt")
writeLines(v2287_unico, "voto2287_extraido.txt")
writeLines(v2285_unico, "voto2285_extraido.txt")
writeLines(v2276_unico, "voto2276_extraido.txt")
writeLines(v2387_unico, "voto2387_extraido.txt")

###########BLOCO 17####

v2376_ext<-pdf_text("Votos Relator/voto_2376.pdf")
v2373_ext<-pdf_text("Votos Relator/voto_2373.pdf")
v2327_ext<-pdf_text("Votos Relator/voto_2327.pdf")
v2497_ext<-pdf_text("Votos Relator/voto_2497.pdf")
v2476_ext<-pdf_text("Votos Relator/voto_2476.pdf")
v2471_ext<-pdf_text("Votos Relator/voto_2471.pdf")
v2447_ext<-pdf_text("Votos Relator/voto_2447.pdf")
v2508_ext<-pdf_text("Votos Relator/voto_2508.pdf")


#Colapsando para ficar em uma string só
v2376_unico <- paste(v2376_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2373_unico <- paste(v2327_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2327_unico <- paste(v2327_ext, 
                    collapse = "\n\n------ Página seguinte ------\n\n")
v2497_unico <- paste(v2497_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2476_unico <- paste(v2476_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2471_unico <- paste(v2471_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2447_unico <- paste(v2447_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2508_unico <- paste(v2508_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v2376_unico, "voto2376_extraido.txt")
writeLines(v2373_unico, "voto2373_extraido.txt")
writeLines(v2327_unico, "voto2327_extraido.txt")
writeLines(v2497_unico, "voto2497_extraido.txt")
writeLines(v2476_unico, "voto2476_extraido.txt")
writeLines(v2471_unico, "voto2471_extraido.txt")
writeLines(v2447_unico, "voto2447_extraido.txt")
writeLines(v2508_unico, "voto2508_extraido.txt")

###########BLOCO 18####

v2507_ext<-pdf_text("Votos Relator/voto_2507.pdf")
v2529_ext<-pdf_text("Votos Relator/voto_2529.pdf")
v2520_ext<-pdf_text("Votos Relator/voto_2520.pdf")
v2547_ext<-pdf_text("Votos Relator/voto_2547.pdf")
v2536_ext<-pdf_text("Votos Relator/voto_2536.pdf")
v2562_ext<-pdf_text("Votos Relator/voto_2562.pdf")
v2548_ext<-pdf_text("Votos Relator/voto_2548.pdf")



#Colapsando para ficar em uma string só
v2507_unico <- paste(v2507_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2529_unico <- paste(v2529_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2520_unico <- paste(v2520_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2547_unico <- paste(v2547_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2536_unico <- paste(v2536_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2562_unico <- paste(v2562_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2548_unico <- paste(v2548_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")


#escreve o Arquivo
writeLines(v2507_unico, "voto2507_extraido.txt")
writeLines(v2529_unico, "voto2529_extraido.txt")
writeLines(v2520_unico, "voto2520_extraido.txt")
writeLines(v2547_unico, "voto2547_extraido.txt")
writeLines(v2536_unico, "voto2536_extraido.txt")
writeLines(v2562_unico, "voto2562_extraido.txt")
writeLines(v2548_unico, "voto2548_extraido.txt")

###ADICIONAL 

pdf_subset("Ações Penais - Acórdãos - Coleta 2/1666.pdf", pages = c(11:57), output = "voto_1666.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1960.pdf", pages = c(13:64), output = "voto_1960.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1972.pdf", pages = c(11:80), output = "voto_1972.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2562.pdf", pages = c(18:126), output = "voto_2562.pdf")

v1666_ext<-pdf_text("Votos Relator/voto_1666.pdf")
v1960_ext<-pdf_text("Votos Relator/voto_1960.pdf")
v1972_ext<-pdf_text("Votos Relator/voto_1972.pdf")
v2562_ext<-pdf_text("Votos Relator/voto_2562.pdf")

#Colapsando para ficar em uma string só
v1666_unico <- paste(v1666_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1960_unico <- paste(v1960_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v1972_unico <- paste(v1972_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2562_unico <- paste(v2562_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

#escreve o Arquivo
writeLines(v1666_unico, "voto1666_extraido.txt")
writeLines(v1960_unico, "voto1960_extraido.txt")
writeLines(v1972_unico, "voto1972_extraido.txt")
writeLines(v2562_unico, "voto2562_extraido.txt")

###############Adicional 2
library(pdftools)
v1468_ext<-pdf_text("Votos Relator/voto_1468.pdf")
v2373_ext<-pdf_text("Votos Relator/voto_2373.pdf")

#Colapsando para ficar em uma string só
v1468_unico <- paste(v1468_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")
v2373_unico <- paste(v2373_ext, 
                     collapse = "\n\n------ Página seguinte ------\n\n")

escreve o Arquivo
writeLines(v1468_unico, "voto1468_extraido.txt")
writeLines(v2373_unico, "voto2373_extraido.txt")
