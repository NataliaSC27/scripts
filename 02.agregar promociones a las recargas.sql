Agregar promoción a la recarga 
UPDATE recargas r
SET promociones_id = 2
FROM tarjetas t
WHERE r.tarjeta_id = t.tarjeta_id
AND t.usuario_id IN (631,522,191,911,572,695,806,365,655,908,158,509,409,20,28,928,628,130,762,353);
