setwd("~/Dropbox/sabeis7/")

ds=read.csv(file="vw_sia_am_coorte_202009302136.csv")

coorte="artrite_reumatoide"

sds = subset(
  ds, 
    no_coorte == coorte
)

library(tidyr)

spread(sds[,c("co_evento","nu_ano_competencia","qt_cnspcn")], names_from = sds$co_evento, values_from = sds$nu_ano_competencia)

library(reshape2)




biologicos=c(604320140, 604320124, 3650104, 601010019, 604380011, 604380062, 
             604380097, 604380070, 604320159, 3650103, 601010027, 604380020,
             601010051, 604380038, 604380089, 3607111, 3650101, 3650102, 
             601010035, 601010043, 604380046, 604380054,
             604680023, 604690010)
