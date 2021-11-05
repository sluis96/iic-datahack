CREATE OR REPLACE PROCEDURE master_transaction.load_t_cortes()
/*@Description: Carga las transacciones de cortes de Tejeduria 
  @author: Sergio Cabrera
*/
-----------------------------------------------
BEGIN
-----------------------------------------------
/*insertando nuevos registros*/
-----------------------------------------------
insert into master_transaction.t_cortes
(
	corte_date,	
	corte_id,
	articulo_id,
	articulo_code,
	articulo_name,
	familia_id,
	familia_name,
	telar_id,
	telar_name,
	corte_peso
)
select 
	cast(cast(TejeMovimientos.fechaRegistro as datetime) as date) as corte_date,
	TejeMovimientosItem.idCT as corte_id,
	TejeMovimientosItem.idArticulo as articulo_id,
	item.CodmaeItemInventario as articulo_code,
	item.NommaeItemInventario as articulo_name,
	item.IdmaeItem_Inventario_Padre as familia_id,
	familia.NommaeItemInventario as familia_name,
	TejeMovimientos.idOrigen as telar_id,
	maeequipos.descripcion as telar_name,
	TejeMovimientosItem.ing as corte_peso
from raw_prod.TejeMovimientosItem TejeMovimientosItem
inner join raw_prod.TejeMovimientos TejeMovimientos on (TejeMovimientos.idmovimiento = TejeMovimientosItem.idmovimiento)
inner join raw_prod.maeequipos maeequipos on (maeequipos.idequipo = TejeMovimientos.idOrigen)
inner join raw_erp.maeItemInventario item on (item.IdmaeItem_Inventario = TejeMovimientosItem.idArticulo)
inner join raw_erp.maeItemInventario familia on (familia.IdmaeItem_Inventario = item.IdmaeItem_Inventario_Padre)
where TejeMovimientosItem.idCentro = 2 AND TejeMovimientosItem.tdCentro = 0 and TejeMovimientos.tdmovimiento = 2;
-----------------------------------------------
END;