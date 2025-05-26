SELECT viaje_id, tarjeta_id, fecha
FROM viajes
WHERE EXTRACT(YEAR FROM fecha) = 2022
ORDER BY fecha

