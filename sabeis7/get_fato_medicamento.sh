db="labxss" # database
hs="localhost" # host
us="usuario"
pw="senha"
pt="5432"



# atualiza quantidade aprovada
for line in $(echo "SELECT table_schema || ',' || table_name FROM information_schema."tables" WHERE table_schema like 'db_coorte_%' and table_name = 'tf_sia_am'" | sort | PGPASSWORD=$pw psql -U $us -h $hs -d $db -p $pt | grep "db_coorte_");do
  sc=$(echo $line | awk -F',' '{print $1}') # schema
  tb=$(echo $line | awk -F',' '{print $2}') # tabela
  
  echo "$(date) $line"
  
  echo "update $sc.$tb A
   set qt_aprovada = B.qt_aprovada ,
       vl_aprovado = B.vl_aprovado 
  from $sc.tf_sia_pa B
 where A.nu_apac = B.nu_apac 
   and A.nu_competencia = B.nu_competencia 
   and A.co_gestao = B.co_gestao 
   and A.co_evento = B.co_evento ;" | PGPASSWORD=$pw psql -U $us -h $hs -d $db -p $pt
done




echo "DROP TABLE IF EXISTS db_datasus.vw_sia_am_coorte;
      CREATE TABLE db_datasus.vw_sia_am_coorte (
	co_evento int8 NULL,
	nu_ano_competencia int4 NULL,
	qt_registros int8 NULL,
	qt_cnspcn int8 NULL,
	qt_cnspcn_menor18 int8 NULL,
	qt_cnspcn_sexo_f int8 NULL,
	qt_apac int8 NULL,
	qt_cnes int8 NULL,
	qt_municipio_residencia int8 NULL,
	qt_aprovada numeric NULL,
	vl_aprovado float8 NULL,
	vl_aprovado_unitario_mediana float8 NULL,
        no_coorte varchar(50) NULL,
	no_origem varchar(50) NULL,
	sg_procedimento varchar(50) NULL,
	no_procedimento varchar(2500) NULL
);" | PGPASSWORD=$pw psql -U $us -h $hs -d $db -p $pt 



# obtem numero de usuarios distintos
for line in $(echo "SELECT table_schema || ',' || table_name FROM information_schema."tables" WHERE table_schema like 'db_coorte_%' and table_name = 'tf_sia_am'" | sort | PGPASSWORD=$pw psql -U $us -h $hs -d $db -p $pt | grep "db_coorte_");do
  sc=$(echo $line | awk -F',' '{print $1}') # schema
  tb=$(echo $line | awk -F',' '{print $2}') # tabela
  
  echo "$(date) $line"

  
  echo " INSERT INTO db_datasus.vw_sia_am_coorte 
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
       replace('$sc','db_coorte_' ,'') as no_coorte,
       replace('tf_sia_am','tf_' ,'') as no_origem
  from $sc.$tb
 group by 1,2
 ) A
 left join db_geral.tf_sigtap_medicamento_distinct B
 on A.co_evento = B.co_sigtap_procedimento::int 
 order by no_procedimento , nu_ano_competencia " | PGPASSWORD=$pw psql -U $us -h $hs -d $db -p $pt 
  
done
