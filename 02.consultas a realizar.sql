--Recargas con descripción de la promoción aplicada
SELECT r.recarga_id, r.tarjeta_id, r.monto, r.fecha_recarga, p.descripcion AS promocion_descripcion
FROM recargas r JOIN promociones p ON r.promociones_id = p.promociones_id;

--Monto total recargado por cada tipo de promoción en los últimos 3 meses
SELECT p.tipo, SUM(r.monto) AS total_recargado FROM recargas r, promociones p
WHERE r.promociones_id = p.promociones_id AND r.fecha BETWEEN DATE '2023-03-01' AND CURRENT_DATE
GROUP BY p.tipo
ORDER BY total_recargado DESC;

--Promociones cuyo nombre contenga la palabra "bonus"
SELECT *
FROM promociones
WHERE LOWER(tipo) LIKE '%bonus%';
