use heladeros;

ALTER TABLE `heladeros`.`contrato_heladero`
    CHANGE COLUMN `numero_contrato` `numero_contrato` VARCHAR(32) NOT NULL;

INSERT INTO contrato_heladero(id_heladero,numero_contrato,tipo,contenido,fecha_inicio,fecha_fin)
SELECT id_heladero,upper(REPLACE(UUID(), '-', '')),'TEMPORAL','', '2025-01-01','2025-12-31' FROM heladero;



select *
from heladero h
         inner join contrato_heladero c on h.id_heladero = c.id_heladero;

select this_.id_heladero                          as id1_8_2_,
       this_.id_concesionario                     as id2_8_2_,
       this_.nombres                              as nombres8_2_,
       this_.apellidos                            as apellidos8_2_,
       concesiona2_.id_concesionario              as id1_7_0_,
       concesiona2_.nombre_conces                 as nombre2_7_0_,
       concesiona2_.distrito                      as distrito7_0_,
       concesiona2_.propietario                   as propieta4_7_0_,
       heladosent3_.id_heladero                   as id2_4_,
       heladosent3_.id_helados_entregado_recibido as id1_4_,
       heladosent3_.id_helados_entregado_recibido as id1_0_1_,
       heladosent3_.id_heladero                   as id2_0_1_,
       heladosent3_.fecha                         as fecha0_1_,
       heladosent3_.created_at                    as created4_0_1_
from heladero this_
         inner join concesionario concesiona2_ on this_.id_concesionario = concesiona2_.id_concesionario
         left outer join helados_entregado_recibido heladosent3_ on this_.id_heladero = heladosent3_.id_heladero
order by this_.apellidos asc;


select *
from heladero this_
         inner join concesionario concesiona2_ on this_.id_concesionario = concesiona2_.id_concesionario
;

select *
from helados_entregado_recibido;

select this_.id_helado              as id1_4_1_,
       this_.nombre_helado          as nombre2_4_1_,
       this_.precio                 as precio4_1_,
       this_.id_stock_helado        as id4_4_1_,
       stockhelad2_.id_stock_helado as id1_1_0_,
       stockhelad2_.cantidad        as cantidad1_0_,
       stockhelad2_.fecha_caducidad as fecha3_1_0_,
       stockhelad2_.created_at      as created4_1_0_,
       stockhelad2_.last_modified   as last5_1_0_
from helado this_
         left outer join stock_helado stockhelad2_ on this_.id_stock_helado = stockhelad2_.id_stock_helado
order by this_.nombre_helado asc;
