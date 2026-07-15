# lda-stf-votos-atos-antidemocraticos
Repositório de reprodutibilidade do artigo "Modelagem de tópicos como instrumento de análise do conteúdo de decisões judiciais: um estudo sobre os votos do relator nas ações penais dos atos antidemocráticos de 8 de janeiro"

Contém os scripts em R utilizados para coleta, pré-processamento, modelagem LDA e análise dos votos do Ministro Alexandre de Moraes em 149 acórdãos do STF relacionados aos atos antidemocráticos de 8 de janeiro de 2023.
 
## Estrutura do repositório
 
```
scripts/
  0_libraries.R                    # Pacotes R necessários
  1_opinionextraction.R            # Extração dos votos do relator a partir dos acórdãos (PDF)
  2_pdftostring.R                  # Conversão dos PDFs extraídos em texto
  3_preprocessing.R                # Tokenização, remoção de stopwords e padronização do vocabulário
  4_exploratorytextanalysis.R      # Análise exploratória (frequência, tf-idf)
  5_topicmodeling.R                # Ajuste do modelo LDA, seleção de k, métricas e nuvens de palavras
  6_metadataanalysis.R             # Análise dos metadados dos acórdãos (pena, sexo, páginas, tópico dominante)
data/
  sw_PT.xlsx                       # Lista de stopwords em português
  stopwords_8janSTF.xlsx           # Lista customizada de stopwords do estudo
  metricsbyk.xlsx                  # Métricas de ajuste do modelo (perplexidade, coerência, exclusividade) por k
  termotopic_Betamatrix.xlsx       # Matriz beta (probabilidade termo-tópico)
  topicdoc_Thetamatrix.xlsx        # Tópico dominante por documento
  votos_tokens.xlsx                # Base de tokens pré-processada (saída do script 3)
graphs/
  Figura1_paginas_x_pena.png              # Nº de páginas dos votos/acórdãos x tipo de pena
  Figura2_top20_palavras.png              # Top-20 palavras mais mencionadas
  Figura3_top10_tfidf.png                 # Top-10 palavras por tf-idf
  Figura4_coerencia_exclusividade.png     # Dispersão coerência x exclusividade (seleção de k)
  Figura5_nuvens_palavras_topicos.jpg     # Nuvens de palavras dos 6 tópicos (grade)
  Figura6_distribuicao_documentos_topicos.png  # Distribuição dos documentos por tópico
  Figura7_scatterplot_tempos_pena.png     # Tempos de pena por tópico
  Figura8_dispersao_topicos_paginas.png   # Dispersão dos tópicos por nº de páginas
  extras/                                 # Gráficos presentes no script mas não na versão final do artigo
```
 
**Nota sobre dados pessoais:** os arquivos `metadata.xlsx` (que contém nomes completos dos réus na coluna `reu`) e `sw_deffendantsnames.xlsx` (lista de nomes usada na etapa de remoção de stopwords) **não são publicados neste repositório**, por conterem dados pessoais identificáveis de réus em processos criminais. Estão disponíveis mediante solicitação direta aos autores.
 
## Como reproduzir a análise
 
Os scripts devem ser executados na ordem numérica (`0` a `6`). Cada um pressupõe a existência dos arquivos de saída do script anterior no diretório de trabalho:
 
1. **`0_libraries.R`** — instala os pacotes R utilizados em todo o pipeline.
2. **`1_opinionextraction.R`** — a partir dos acórdãos completos em PDF (não incluídos neste repositório por serem arquivos públicos, mas volumosos — podem ser obtidos diretamente na [página de jurisprudência do STF](https://jurisprudencia.stf.jus.br)), extrai apenas as páginas correspondentes ao voto do relator.
3. **`2_pdftostring.R`** — converte os PDFs dos votos extraídos em texto plano.
4. **`3_preprocessing.R`** — tokeniza o texto, remove stopwords (usando as listas em `data/`) e aplica a padronização de vocabulário (lematização manual de ~1.292 variações flexionais, resultado de revisão especializada do vocabulário). Gera `votos_tokens.xlsx`.
5. **`4_exploratorytextanalysis.R`** — gera as estatísticas de frequência de palavras e tf-idf (Figuras 2 e 3 do artigo).
6. **`5_topicmodeling.R`** — monta a matriz documento-termo, testa k entre 2 e 14 tópicos (coerência NPMI, perplexidade e exclusividade), ajusta o modelo LDA final (k=6, α=0,16, η=1×10⁻⁴, método de Gibbs, seed=123) e gera as nuvens de palavras por tópico (Figura 5).
7. **`6_metadataanalysis.R`** — cruza o tópico dominante de cada documento com os metadados dos acórdãos (tipo de pena, sexo do réu, número de páginas).

## Dados
 
Os acórdãos originais em PDF não são redistribuídos neste repositório por serem arquivos volumosos e de acesso público direto no site do STF. As matrizes intermediárias (tokens, beta, theta) e as métricas de ajuste estão disponíveis em `data/`, permitindo reproduzir a modelagem de tópicos e as análises a partir da etapa de pré-processamento sem a necessidade de reprocessar os PDFs originais. A tabela completa de metadados (com identificação dos réus) pode ser disponibilizada mediante solicitação direta aos autores, resguardando dados pessoais de terceiros.
 
## Gráficos
 
A pasta `graphs/` contém as 8 figuras geradas pelos scripts e utilizadas no artigo (Figuras 1 a 8), na mesma numeração da versão final do texto, permitindo conferência direta entre o repositório e o artigo publicado. Também foi incluída uma pasta extra de gráficos presentes nos scripts que não estão na versão final do artigo.
 
## Citação
 
Se utilizar este código, por favor cite o artigo:
 
> [inserir referência completa do artigo após publicação]
 
## Licença
 
[MIT]
 
## Contato
 
[nome, e-mail ou ORCID dos autores]
