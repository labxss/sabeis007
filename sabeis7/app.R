#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

ds=read.csv(file="vw_sia_am_coorte_202009302136.csv")

biologicos=c(604320140, 604320124, 3650104, 601010019, 604380011, 604380062, 
             604380097, 604380070, 604320159, 3650103, 601010027, 604380020,
             601010051, 604380038, 604380089, 3607111, 3650101, 3650102, 
             601010035, 601010043, 604380046, 604380054,
             604680023, 604690010)

library(shiny)
library(reshape2)
library(DT) # datatable

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel(
        "SABEIS - Sala Aberta de Situação em Saúde", windowTitle = "SABEIS"
    ),
    
    tags$h1("Medicamentos"),
    
    tags$h3("Apresentação"),
    
    tags$p("Bem vindo à plataforma SABEIS."),
    
    tags$p("Este módulo é dedicato à extração de informações básicas de medicamentos para doenças com diretriz CONITEC."),
    
    tags$h3("Instruções"),
    
    tags$p("Selecione uma doença e copie a tabela usando os botões na parte superior."),
    
    tags$h3("Fonte"),
    
    tags$p(
        "Dados baixados a partir do  ",
        tags$a(href="ftp://ftp.datasus.gov.br/dissemin/publicos/", "ftp.datasus.gov.br"),
        "em 28/08/2020."
    ),
    
    p(
      
    ),
    
    tags$h3("Citação"),
    
    tags$p('Ferre, F.; de Oliveira, G. L. A.; de Queiroz, M. J. & Gonçalves, F. (2020), 
           Sala de Situação aberta com dados administrativos para gestão de Protocolos Clínicos e Diretrizes Terapêuticas de tecnologias providas pelo SUS, 
           in SBCAS 2020.'),
    
    tags$h3("Código-fonte"),
    
    tags$p(
        "Baixe o arquivo RShiny em ",
        tags$a(href="https://github.com/labxss/sabeis007", "https://github.com/labxss/sabeis007")
    ),
    
    tags$hr(),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        sidebarPanel(
            selectizeInput(
                inputId = 'inCoorte', 
                label = 'Escolha uma doença (digite ou liste)', 
                choices=c(
                    'Acidente Vascular Cerebral (AVC) - Trombólise' = 'acidente_vascular',
                    'Acromegalia' = 'acromegalia',
                    'Adenocarcinoma de Próstata' = 'c_prostata',
                    'Anemia Aplástica Adquirida' = 'anemia_aplastica_adquirida',
                    'Anemia Aplástica, Mielodisplasia e Neutropenia' = 'anemia_aplastica',
                    'Anemia em pacientes com Insuficiência Renal' = 'anemia_renal',
                    'Anemia Hemolítica Autoimune' = 'anemia_hemolitica',
                    'Anemia por Deficiência de Ferro' = 'anemia_ferro',
                    'Angioedema' = 'angiodema',
                    'Aplasia Pura Adquirida Crônica da série vermelha' = 'aplasia',
                    'Artrite Psoríaca' = 'artrite_psoriaca',
                    'Artrite Reativa' = 'artrite_reativa',
                    'Artrite Reumatoide e Artrite Idiopática Juvenil' = 'artrite_reumatoide',
                    'Asma' = 'asma',
                    'Atrofia Muscular Espinhal' = 'atrofia',
                    'Câncer de Cabeça e Pescoço' = 'c_cabeca',
                    'Câncer de Cólon e Reto' = 'c_colon',
                    'Câncer de Estômago' = 'c_estomago',
                    'Câncer de Fígado - Adultos' = 'c_figado',
                    'Câncer de Pulmão' = 'c_pulmao',
                    'Carcinoma de Células Renais' = 'c_renal',
                    'Carcinoma de Esôfago' = 'c_esofago',
                    'Carcinoma de Mama' = 'c_mama',
                    'Carcinoma Diferenciado de Tireóide' = 'c_tireoide',
                    'Colangite Biliar Primária' = 'colangite',
                    'Comportamento Agressivo no Autismo' = 'autismo',
                    'Deficiência de Biotinidase' = 'biotinidase',
                    'Deficiência de Hormônio do Crescimento - Hipopitui' = 'hipopituitarismo',
                    'Degeneração Macular Relacionada com a Idade' = 'macular',
                    'Dermatomiosite e Polimiosite' = 'dermatomiosite',
                    'Diabete Melito Tipo 1' = 'diabetes_melito',
                    'Diabetes Insípido' = 'diabetes_insipido',
                    'Dislipidemia para a Prevenção de Eventos Cardiov.' = 'dislipidemia',
                    'Distonias focais e Espasmo Hemifacial' = 'distonias',
                    'Distúrbio Mineral Ósseo na Doença Renal Crônica' = 'osseo',
                    'Doença Celíaca' = 'celiaca',
                    'Doença de Alzheimer' = 'alzheimer',
                    'Doença de Chagas' = 'chagas',
                    'Doença de Crohn' = 'crohn',
                    'Doença de Gaucher' = 'gaucher',
                    'Doença de Paget' = 'paget',
                    'Doença de Parkinson' = 'parkinson',
                    'Doença de Wilson' = 'wilson',
                    'Doença Falciforme' = 'falciforme',
                    'Doença Pulmonar Obstrutiva Crônica (Retificado em' = 'dpoc',
                    'Dor Crônica' = 'dor_cronica',
                    'Endometriose' = 'endometriose',
                    'Epilepsia' = 'epilepsia',
                    'Esclerose Lateral Amiotrófica' = 'esclerose_amiotrofica',
                    'Esclerose Múltipla' = 'esclerose_multipla',
                    'Esclerose Sistêmica' = 'esclerose_sistemica',
                    'Espasticidade' = 'espasticidade',
                    'Espondilite Ancilosante' = 'espondilite',
                    'Espondilose' = 'espondilose',
                    'Esquizofrenia' = 'esquizofrenia',
                    'Fenilcetonúria' = 'fenilcetonuria',
                    'Fibrose Cística - Insuficiência Pancreática' = 'fibrose_cistica_pancreatica',
                    'Fibrose Cística - Manifestações Pulmonares' = 'fibrose_cistica_pulmonar',
                    'Glaucoma' = 'glaucoma',
                    'Hemangioma Infantil' = 'hemangioma',
                    'Hemoglobinúria Paroxística Noturna' = 'hemoglobinuria',
                    'Hepatite Autoimune' = 'hepatite_autoimune',
                    'Hepatite B e Coinfecções' = 'hepatite_b',
                    'Hepatite C e coinfecções' = 'hepatite_c',
                    'Hidradenite Supurativa' = 'hidradenite',
                    'Hiperplasia Adrenal Congênita' = 'adrenal_congenita',
                    'Hiperprolactinemia' = 'hiperprolactinemia',
                    'Hipertensão Arterial Pulmonar' = 'hipertensao_pulmonar',
                    'Hipoparatireoidismo' = 'hipopparatireoidismo',
                    'Hipotireoidismo Congênito' = 'hipotireoidismo',
                    'Homocistinúria Clássica' = 'homocistinuria',
                    'Ictioses Hereditárias' = 'ictiose',
                    'Imunodeficiência Primária' = 'imunosuficiencia',
                    'Imunossupressão no Transplante Hepático em Adulto' = 'hepatico',
                    'Imunossupressão no Transplante Renal (Republicado' = 'renal',
                    'Incontinência Urinária não Neurogênica' = 'incontinencia',
                    'Insuficiência Adrenal Primária' = 'adrenal_primaria',
                    'Insuficiência Pancreática Exócrina' = 'insuficiencia_pancreatica',
                    'Leimioma de útero' = 'leimioma',
                    'Leucemia Linfoblástica Aguda Cromossoma Philadelph' = 'c_leucemia_linfoblastica',
                    'Leucemia Mieloide Aguda - Adultos e Leucemia Mielo' = 'c_leucemia_mieloide',
                    'Leucemia Mieloide Crônica - Adultos e Leucemia Mie' = 'leucemia_mieloide',
                    'Linfoma Difuso de Grandes Células B - Adultos' = 'c_celula_b',
                    'Linfoma Folicular' = 'c_folicular',
                    'Lúpus Eritematoso Sistêmico' = 'lupus',
                    'Melanoma Cutâneo' = 'c_cutaneo',
                    'Miastenia Gravis' = 'miastenia',
                    'Mieloma Múltiplo' = 'c_mieloma',
                    'Mucopolissacaridose tipo II' = 'mucopolissacaridose2',
                    'Mucopolissacaridose tipo I' = 'mucopolissacaridose1',
                    'Mucopolissacaridose tipo IV A e Mucopolissacaridos' = 'mucopolissacaridose',
                    'Neoplasia Maligna Epitelial de Ovário' = 'c_ovario',
                    'Osteogênese Imperfeita' = 'osteogenese',
                    'Osteoporose' = 'osteoporose',
                    'Polineuropatia Amiloidótica Familiar' = 'polineuropatia',
                    'Profilaxia da reinfecção pelo Vírus da Hepatite B' = 'hepatite_b_transp',
                    'Psoríase' = 'psoriase',
                    'Puberdade Precoce Central' = 'puberdade',
                    'Púrpura Trombocitopênica Idiopática' = 'purpura',
                    'Raquitismo e Osteomalácia' = 'raquitismo',
                    'Retocolite Ulcerativa' = 'retocolite',
                    'Síndrome de Guillain-Barré' = 'guillain_barre',
                    'Síndrome de Ovários Policísticos' = 'ovario_policisticos',
                    'Síndrome de Turner' = 'turner',
                    'Síndrome Hipereosinofílica com mesilato de imatini' = 'hipereosinofilica',
                    'Síndrome Nefrótica Primária em Crianças e Adolesce' = 'nefrotica',
                    'Sobrecarga de Ferro' = 'sobrecarga_ferro',
                    'Síndrome Respiratória Agura Grave - SRAG' = 'srag',
                    'Tabagismo' = 'tabagismo',
                    'Transtorno Afetivo Bipolar do tipo I' = 'bipolar',
                    'Transtorno Esquizoafetivo' = 'esquizoafetivo',
                    'Tromboembolismo Venoso em Gestantes com Trombofili' = 'tromboembolismo',
                    'Tumor Cerebral - Adultos' = 'c_cerebral',
                    'Tumor do Estroma Gastrointestinal' = 'c_gastro',
                    'Uveítes Não-Infecciosas' = 'uveite'
                ),
                selected = '1'
            ),
            
            sliderInput(
                inputId = 'inAno',
                label = 'Período',
                min = 2008,
                max = 2020,
                sep = "",
                value=c(2008,2020)
            ),
            
            checkboxGroupInput(
                "inCampos", 
                "Variáveis para exibir",
                c( 
                  # 'Ano (nu_ano_competencia)'='nu_ano_competencia', 
                  'qt_registros: Registros'='qt_registros', 
                  'qt_cnspcn: Usuários segundo Cartão Nacional de Saúde'='qt_cnspcn', 
                  'qt_cnspcn_menor18: Usuários com idade <=18'='qt_cnspcn_menor18', 
                  'qt_cnspcn_sexo_f: Usuárias do sexo feminino'='qt_cnspcn_sexo_f', 
                  'qt_apac: APAC distintas (número de autorização de procedimento ambulatorial)'='qt_apac', 
                  'qt_cnes: Estabelecimentos CNES distintos'='qt_cnes', 
                  'qt_municipio_residencia: Municípios de residência distintos'='qt_municipio_residencia', 
                  'qt_aprovada: Quantidade aprovada'='qt_aprovada', 
                  'vl_aprovado: Valor aprovado'='vl_aprovado', 
                  'vl_aprovado_unitario_mediana: Mediana unitária do valor aprovado'='vl_aprovado_unitario_mediana', 
                  'no_coorte: Coorte segundo CID-10 da diretriz CONITEC'='no_coorte', 
                  'no_origem: Origem (sistema e subsistema do SUS)'='no_origem', 
                  'sg_procedimento: Sigla do medicaemento'='sg_procedimento', 
                  'no_procedimento: Medicamento'='no_procedimento'),
                selected = c(
                    "nu_ano_competencia", 
                    "qt_cnspcn",
                    "qt_aprovada",
                    "no_procedimento",
                    "no_coorte"
                )
            ),

            radioButtons(
                "inMedicamentos", 
                "Mesmos medicamentos para outras doenças",
                c("Não (apenas registros da coorte selecionada)",
                  "Sim (coletar para todas as coortes)")
            ),
                        
            radioButtons(
                "inTipo", 
                "Tipo",
                c("Todos",
                  "Biológicos",
                  "Não Biológicos")
            ),
            
            radioButtons(
                "inApresentacao", 
                "Apresentação",
                c("Anos em linha (todas as variáveis)",
                  "Anos em coluna (apenas o primeiro quantificador)")
            )
            
        ), # sidebarPanel
        
        # Show a plot of the generated distribution
        mainPanel(
            htmlOutput("rb_apresentacao"),
            DT::dataTableOutput("tf_evento_co_evento"),
            hr()
        )
        
    ) # sidebarLayout
) # fluidPage

# Define server logic required to draw a histogram
server <- function(input, output) {
    
   output$rb_apresentacao = renderText(
       if (input$inApresentacao == "Anos em coluna (apenas o primeiro quantificador)"){
           paste0(
               "<h2>", input$inApresentacao, "</h2> <br>", 
               paste(as.character(input$inCampos[1]), collapse=", "),
               "<br><hr>"
           )
       } else {
           paste0(
               "<h2>", input$inApresentacao, "</h2> <br>", 
               paste(as.character(input$inCampos), collapse=", "),
               "<br><hr>"
           )
       }
   )

   # ----------------------------------------------------------------------------
   
   output$tf_evento_co_evento = DT::renderDataTable({
        
       if (input$inMedicamentos == "Não (apenas registros da coorte selecionada)"){
           sds = subset(
               ds, 
               nu_ano_competencia >= input$inAno[1] & 
                   nu_ano_competencia <= input$inAno[2] &
                   no_coorte == input$inCoorte 
           )[,c("co_evento","nu_ano_competencia", input$inCampos), drop = FALSE]
       } else {
           
           co_evento = unique(subset(
               ds, 
               nu_ano_competencia >= input$inAno[1] & 
                   nu_ano_competencia <= input$inAno[2] &
                   no_coorte == input$inCoorte 
           )[,"co_evento"])
           
           sds = subset(
               ds, 
               nu_ano_competencia >= input$inAno[1] & 
                   nu_ano_competencia <= input$inAno[2] &
                   co_evento %in% co_evento
           )[,c("co_evento","nu_ano_competencia", input$inCampos), drop = FALSE]
           
       }
       
       
       if (input$inTipo == "Biológicos"){
          sds = subset(
               sds, 
               co_evento %in% biologicos
           )
       }
       
       if (input$inTipo == "Não Biológicos"){
           sds = subset(
               sds, 
               !co_evento %in% biologicos
           )
       }
       
       if (input$inApresentacao == "Anos em coluna (apenas o primeiro quantificador)"){
           sds = dcast(
               sds, 
               co_evento ~ nu_ano_competencia, 
               value.var=input$inCampos[1], 
               fun.aggregate = sum
           )
       }
       
        datatable(
            
            data= sds,
            
            # colnames = c( ),
            rownames= FALSE,
            extensions = 'Buttons', options = list(
                dom = 'Bfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                paging =FALSE
            )
            
        )
    })  
}

# Run the application 
shinyApp(ui = ui, server = server)
