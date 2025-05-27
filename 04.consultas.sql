--Consultas 
-- Consulta total recargas y monto por cada medio de pago
SELECT m.medio_id, m.nombre AS medio_pago, COUNT(r.recarga_id) AS total_recargas, SUM(r.monto) AS monto_total
FROM recargas r
JOIN medios_pago m ON r.medio_id = m.medio_id
GROUP BY m.medio_id, m.nombre
ORDER BY monto_total DESC;
--Consulta detalle de recargas con medio de pago y promoción aplicada

SELECT r.recarga_id, r.monto, m.nombre AS medio_pago, p.nombre AS promocion, p.tipo FROM recargas r
JOIN medios_pago m ON r.medio_id = m.medio_id
LEFT JOIN promociones p ON r.promociones_id = p.promociones_id
WHERE p.tipo IS NOT NULL
ORDER BY r.recarga_id;
-- Consulta de recargas realizadas con un medio de pago específico por mes y año 
SELECT COUNT(*) AS total_recargas, SUM(monto) AS monto_total FROM recargas
WHERE medio_id = 2
AND EXTRACT(MONTH FROM fecha) = 04
AND EXTRACT(YEAR FROM fecha) = 2024;
