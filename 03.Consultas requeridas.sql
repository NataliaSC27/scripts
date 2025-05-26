--Viajes sin registro de validación
SELECT v.* FROM viajes v
LEFT JOIN validaciones val ON v.viaje_id = val.viaje_id
WHERE val.viaje_id IS NULL;
--Validaciones realizadas por dispositivos de tipo móvil en abril de 2025
SELECT COUNT(*) 
FROM validaciones v
JOIN dispositivos d ON v.dispositivo_id = d.dispositivo_id
WHERE d.tipo = 'móvil'
AND v.fecha BETWEEN '2025-04-01' AND '2025-04-30';
--Dispositivo con mayor cantidad de validaciones
SELECT dispositivo_id, COUNT(*) as total
FROM validaciones
GROUP BY dispositivo_id
ORDER BY total DESC
LIMIT 1;
