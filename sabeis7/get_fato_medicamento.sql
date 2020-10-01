SELECT table_schema || ',' || table_name FROM information_schema."tables" WHERE table_schema like 'db_coorte_%' and table_name = 'tf_sia_am'



update db_coorte_esclerose_multipla.tf_sia_am A
   set qt_aprovada = B.qt_aprovada ,
       vl_aprovado = B.vl_aprovado 
  from db_coorte_esclerose_multipla.tf_sia_pa B
 where A.nu_apac = B.nu_apac 
   and A.nu_competencia = B.nu_competencia 
   and A.co_gestao = B.co_gestao 
   and A.co_evento = B.co_evento ;

drop table if exists tmp.tmp;
create table tmp.tmp as


create table db_geral.tf_sigtap_medicamento_distinct as
select distinct co_sigtap_procedimento, sg_procedimento, no_procedimento from db_geral.tf_sigtap_medicamento order by 1

select count(*) from db_geral.tf_sigtap_medicamento

drop table if exists tmp.tm_esclerose_multipla;
create table tmp.tm_esclerose_multipla as
select A.*, B.sg_procedimento, B.no_procedimento 
from
(
select co_evento,
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,

       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       replace('db_coorte_esclerose_multipla','db_coorte_' ,'') as no_coorte,
       replace('tf_sia_am','tf_' ,'') as no_origem
  from db_coorte_esclerose_multipla.tf_sia_am
 group by 1,2
 ) A
 left join db_geral.tf_sigtap_medicamento_distinct B
 on A.co_evento = B.co_sigtap_procedimento::int 
 order by no_procedimento , nu_ano_competencia 
 

 drop table tmp.tm_teriflunomida604540043;
 

create table tmp.tm_teriflunomida604540043 as 
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2020
 where co_evento = 604540043
 group by 1
union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2019
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2018
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2017
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2016
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2015
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2014
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2013
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2012
 where co_evento = 604540043
 group by 1
  union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2011
 where co_evento = 604540043
 group by 1
 union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2010
 where co_evento = 604540043
 group by 1
  union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2009
 where co_evento = 604540043
 group by 1
  union
select 
       substr(nu_competencia::text,1,4)::int nu_ano_competencia,
       min(nu_competencia) as nu_competencia_min,
       max(nu_competencia) as nu_competencia_max,
       count(*) as qt_registros,
       count(distinct nu_cnspcn) as qt_cnspcn,
       count(distinct case when nu_idade <= 18 then nu_cnspcn else null end ) as qt_cnspcn_menor18,
       count(distinct case when sg_sexo = 'F' then nu_cnspcn else null end ) as qt_cnspcn_sexo_f,
       count(distinct nu_apac) as qt_apac,
       count(distinct co_cnes_estabelecimento) as qt_cnes,
       count(distinct co_ibge_municipio_residencia) as qt_municipio_residencia,
       sum(qt_aprovada ) as qt_aprovada,
       sum(vl_aprovado) as vl_aprovado,
       percentile_disc(0.5) within group (order by case when vl_aprovado > 0 then vl_aprovado/qt_aprovada else null end) as vl_aprovado_unitario_mediana,
       string_agg(distinct co_cidpri, ' ') as co_cidpri,
       string_agg(distinct co_cidsec, ' ') as co_cidsec
  from db_datasus.tf_sia_am_2008
 where co_evento = 604540043
 group by 1