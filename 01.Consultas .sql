--Las 5 tarjetas con mas cambios 
SELECT  tarjeta_id, COUNT(*) AS total_cambios FROM auditoria_tarjeta
GROUP BY  tarjeta_id ORDER BY total_cambios DESC
LIMIT 5;
--Contar todos los cambios de estado en cada tarjeta por mes , en el ultimo año 
SELECT  tarjeta_id, EXTRACT(MONTH FROM fecha_cambio) AS mes,
COUNT(*) AS total_cambios FROM auditoria_tarjeta WHERE EXTRACT(YEAR FROM fecha_cambio) = 2024
GROUP BY tarjeta_id, mes ORDER BY mes, total_cambios DESC;
