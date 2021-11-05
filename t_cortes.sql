CREATE OR REPLACE TABLE `iic-datahack.master_transaction.t_cortes`
(
corte_date date options(description="Fecha del corte"),
corte_id int64 NOT NULL options(description="Identificador del corte"),
articulo_id int64 options(description="Identificador del articulo del corte"),
articulo_code string options(description="Codigo del articulo del corte"),
articulo_name string options(description="Nombre del articulo del corte"),
familia_id int64 options(description="Identificador de la familia del corte"),
familia_name string options(description="Nombre de la familia del corte"),
telar_id int64 options(description="Identificador del telar"),
telar_name string options(description="Nombre del telar"),
corte_peso int64 options(description="Peso del corte")
)
PARTITION BY corte_date
options
(
description = "Estructura que almacena los cortes de Tejeduria."
);