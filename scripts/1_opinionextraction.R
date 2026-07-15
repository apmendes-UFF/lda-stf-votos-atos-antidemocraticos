#==RAPPOUTEUR'S OPINION EXTRACTION FROM DE ORIGINAL COURT DECISION FILE =====#


#===Libraries====
library(pdftools)
library(stringr)


#====COLETA 1 (First Sampling) ====


pdf_subset("Ações Penais - Acórdãos/1057.pdf", pages = c(25:140), output = "voto_1057.pdf")
pdf_subset("Ações Penais - Acórdãos/1058.pdf", pages = c(24:131), output = "voto_1058.pdf")
pdf_subset("Ações Penais - Acórdãos/1060.pdf", pages = c(92:200), output = "voto_1060.pdf")
pdf_subset("Ações Penais - Acórdãos/1066.pdf", pages = c(26:138), output = "voto_1066.pdf")

pdf_subset("Ações Penais - Acórdãos/1071.pdf", pages = c(25:124), output = "voto_1071.pdf")
pdf_subset("Ações Penais - Acórdãos/1075.pdf", pages = c(26:150), output = "voto_1075.pdf")
pdf_subset("Ações Penais - Acórdãos/1077.pdf", pages = c(24:128), output = "voto_1077.pdf")
pdf_subset("Ações Penais - Acórdãos/1105.pdf", pages = c(12:52), output = "voto_1105.pdf")

pdf_subset("Ações Penais - Acórdãos/1109.pdf", pages = c(23:118), output = "voto_1109.pdf")
pdf_subset("Ações Penais - Acórdãos/1112.pdf", pages = c(24:128), output = "voto_1112.pdf")
pdf_subset("Ações Penais - Acórdãos/1113.pdf", pages = c(24:143), output = "voto_1113.pdf")
pdf_subset("Ações Penais - Acórdãos/1116.pdf", pages = c(24:125), output = "voto_1116.pdf")
pdf_subset("Ações Penais - Acórdãos/1123.pdf", pages = c(25:141), output = "voto_1123.pdf")

pdf_subset("Ações Penais - Acórdãos/1125.pdf", pages = c(26:146), output = "voto_1125.pdf")
pdf_subset("Ações Penais - Acórdãos/1130.pdf", pages = c(26:120), output = "voto_1130.pdf")
pdf_subset("Ações Penais - Acórdãos/1133.pdf", pages = c(25:135), output = "voto_1133.pdf")
pdf_subset("Ações Penais - Acórdãos/1147.pdf", pages = c(23:101), output = "voto_1147.pdf")
pdf_subset("Ações Penais - Acórdãos/1153.pdf", pages = c(24:146), output = "voto_1153.pdf")

pdf_subset("Ações Penais - Acórdãos/1156.pdf", pages = c(23:124), output = "voto_1156.pdf")
pdf_subset("Ações Penais - Acórdãos/1163.pdf", pages = c(24:136), output = "voto_1163.pdf")
pdf_subset("Ações Penais - Acórdãos/1173.pdf", pages = c(24:137), output = "voto_1173.pdf")
pdf_subset("Ações Penais - Acórdãos/1176.pdf", pages = c(23:120), output = "voto_1176.pdf")
pdf_subset("Ações Penais - Acórdãos/1177.pdf", pages = c(26:138), output = "voto_1177.pdf")

pdf_subset("Ações Penais - Acórdãos/1178.pdf", pages = c(23:135), output = "voto_1178.pdf")
pdf_subset("Ações Penais - Acórdãos/1179.pdf", pages = c(23:131), output = "voto_1179.pdf")
pdf_subset("Ações Penais - Acórdãos/1180.pdf", pages = c(23:116), output = "voto_1180.pdf")
pdf_subset("Ações Penais - Acórdãos/1183.pdf", pages = c(24:130), output = "voto_1183.pdf")
pdf_subset("Ações Penais - Acórdãos/1184.pdf", pages = c(20:103), output = "voto_1184.pdf")

pdf_subset("Ações Penais - Acórdãos/1190.pdf", pages = c(25:132), output = "voto_1190.pdf")
pdf_subset("Ações Penais - Acórdãos/1193.pdf", pages = c(11:50), output = "voto_1193.pdf")
pdf_subset("Ações Penais - Acórdãos/1194.pdf", pages = c(11:49), output = "voto_1194.pdf")
pdf_subset("Ações Penais - Acórdãos/1228.pdf", pages = c(11:56), output = "voto_1228.pdf")
pdf_subset("Ações Penais - Acórdãos/1250.pdf", pages = c(11:57), output = "voto_1250.pdf")

pdf_subset("Ações Penais - Acórdãos/1268.pdf", pages = c(23:131), output = "voto_1268.pdf")
pdf_subset("Ações Penais - Acórdãos/1269.pdf", pages = c(23:133), output = "voto_1269.pdf")
pdf_subset("Ações Penais - Acórdãos/1285.pdf", pages = c(11:46), output = "voto_1285.pdf")
pdf_subset("Ações Penais - Acórdãos/1296.pdf", pages = c(11:42), output = "voto_1296.pdf")
pdf_subset("Ações Penais - Acórdãos/1314.pdf", pages = c(11:54), output = "voto_1314.pdf")

pdf_subset("Ações Penais - Acórdãos/1359.pdf", pages = c(11:58), output = "voto_1359.pdf")
pdf_subset("Ações Penais - Acórdãos/1373.pdf", pages = c(19:41), output = "voto_1373.pdf")
pdf_subset("Ações Penais - Acórdãos/1380.pdf", pages = c(22:118), output = "voto_1380.pdf")
pdf_subset("Ações Penais - Acórdãos/1381.pdf", pages = c(25:137), output = "voto_1381.pdf")
pdf_subset("Ações Penais - Acórdãos/1388.pdf", pages = c(26:143), output = "voto_1388.pdf")

pdf_subset("Ações Penais - Acórdãos/1391.pdf", pages = c(25:133), output = "voto_1391.pdf")
pdf_subset("Ações Penais - Acórdãos/1403.pdf", pages = c(23:141), output = "voto_1403.pdf")
pdf_subset("Ações Penais - Acórdãos/1405.pdf", pages = c(25:142), output = "voto_1405.pdf")
pdf_subset("Ações Penais - Acórdãos/1413.pdf", pages = c(18:97), output = "voto_1413.pdf")
pdf_subset("Ações Penais - Acórdãos/1416.pdf", pages = c(26:139), output = "voto_1416.pdf")

pdf_subset("Ações Penais - Acórdãos/1419.pdf", pages = c(23:132), output = "voto_1419.pdf")
pdf_subset("Ações Penais - Acórdãos/1421.pdf", pages = c(22:108), output = "voto_1421.pdf")
pdf_subset("Ações Penais - Acórdãos/1422.pdf", pages = c(21:114), output = "voto_1422.pdf")
pdf_subset("Ações Penais - Acórdãos/1423.pdf", pages = c(17:36), output = "voto_1423.pdf")
pdf_subset("Ações Penais - Acórdãos/1427.pdf", pages = c(23:136), output = "voto_1427.pdf")

pdf_subset("Ações Penais - Acórdãos/1429.pdf", pages = c(26:134), output = "voto_1429.pdf")
pdf_subset("Ações Penais - Acórdãos/1432.pdf", pages = c(20:107), output = "voto_1432.pdf")
pdf_subset("Ações Penais - Acórdãos/1473.pdf", pages = c(10:43), output = "voto_1473.pdf")
pdf_subset("Ações Penais - Acórdãos/1488.pdf", pages = c(26:146), output = "voto_1488.pdf")
pdf_subset("Ações Penais - Acórdãos/1492.pdf", pages = c(23:125), output = "voto_1492.pdf")
pdf_subset("Ações Penais - Acórdãos/1498.pdf", pages = c(25:134), output = "voto_1498.pdf")
pdf_subset("Ações Penais - Acórdãos/1499.pdf", pages = c(25:141), output = "voto_1499.pdf")

#====COLETA 2 (Second Sampling) ====

pdf_subset("Ações Penais - Acórdãos - Coleta 2/1096.pdf", pages = c(14:66), output = "voto_1096.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1103.pdf", pages = c(11:47), output = "voto_1103.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1224.pdf", pages = c(11:48), output = "voto_1224.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1337.pdf", pages = c(10:48), output = "voto_1337.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/1464.pdf", pages = c(13:62), output = "voto_1464.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1468.pdf", pages = c(11:49), output = "voto_1468.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1521.pdf", pages = c(12:66), output = "voto_1521.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1548.pdf", pages = c(12:59), output = "voto_1548.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/1573.pdf", pages = c(11:46), output = "voto_1573.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1629.pdf", pages = c(10:44), output = "voto_1629.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1642.pdf", pages = c(11:57), output = "voto_1642.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1705.pdf", pages = c(12:62), output = "voto_1705.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1735.pdf", pages = c(12:52), output = "voto_1735.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/1786.pdf", pages = c(10:50), output = "voto_1786.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1789.pdf", pages = c(10:55), output = "voto_1789.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1792.pdf", pages = c(11:52), output = "voto_1792.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1818.pdf", pages = c(11:58), output = "voto_1818.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1842.pdf", pages = c(11:47), output = "voto_1842.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/1857.pdf", pages = c(12:63), output = "voto_1857.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1858.pdf", pages = c(12:64), output = "voto_1858.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1935.pdf", pages = c(10:47), output = "voto_1935.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1960.pdf", pages = c(13:64), output = "voto_1960.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/1970.pdf", pages = c(14:66), output = "voto_1970.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2006.pdf", pages = c(13:63), output = "voto_2006.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2015.pdf", pages = c(11:57), output = "voto_2015.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2023.pdf", pages = c(11:56), output = "voto_2023.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2057.pdf", pages = c(11:55), output = "voto_2057.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2061.pdf", pages = c(12:60), output = "voto_2061.pdf")

library(pdftools)

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2080.pdf", pages = c(11:57), output = "voto_2080.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2111.pdf", pages = c(12:64), output = "voto_2111.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2130.pdf", pages = c(11:50), output = "voto_2130.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2137.pdf", pages = c(12:62), output = "voto_2137.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2139.pdf", pages = c(10:54), output = "voto_2139.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2144.pdf", pages = c(13:66), output = "voto_2144.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2148.pdf", pages = c(12:59), output = "voto_2148.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2150.pdf", pages = c(11:53), output = "voto_2150.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2157.pdf", pages = c(11:59), output = "voto_2157.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2162.pdf", pages = c(11:57), output = "voto_2162.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2174.pdf", pages = c(11:59), output = "voto_2174.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2175.pdf", pages = c(11:47), output = "voto_2175.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2187.pdf", pages = c(11:58), output = "voto_2187.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2219.pdf", pages = c(12:61), output = "voto_2219.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2245.pdf", pages = c(12:66), output = "voto_2245.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2276.pdf", pages = c(12:64), output = "voto_2276.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2285.pdf", pages = c(10:48), output = "voto_2285.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2287.pdf", pages = c(13:67), output = "voto_2287.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2315.pdf", pages = c(11:52), output = "voto_2315.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2320.pdf", pages = c(13:63), output = "voto_2320.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2327.pdf", pages = c(11:48), output = "voto_2327.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2373.pdf", pages = c(12:51), output = "voto_2373.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2376.pdf", pages = c(11:47), output = "voto_2376.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2387.pdf", pages = c(12:60), output = "voto_2387.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2447.pdf", pages = c(14:103), output = "voto_2447.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2471.pdf", pages = c(10:50), output = "voto_2471.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2476.pdf", pages = c(11:61), output = "voto_2476.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2497.pdf", pages = c(23:122), output = "voto_2497.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2507.pdf", pages = c(12:94), output = "voto_2507.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2508.pdf", pages = c(14:134), output = "voto_2508.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2520.pdf", pages = c(13:106), output = "voto_2520.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2529.pdf", pages = c(14:85), output = "voto_2529.pdf")

pdf_subset("Ações Penais - Acórdãos - Coleta 2/2536.pdf", pages = c(13:69), output = "voto_2536.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2547.pdf", pages = c(14:101), output = "voto_2547.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2548.pdf", pages = c(13:105), output = "voto_2548.pdf")
pdf_subset("Ações Penais - Acórdãos - Coleta 2/2562.pdf", pages = c(13:126), output = "voto_2562.pdf")





