--Consulta tarjeta premium y fecha de adquisición 
SELECT  u.usuario_id, u.nombre, t.fecha_adquisicion
FROM usuarios u JOIN tarjetas t ON u.usuario_id = t.usuario_id
WHERE t.tipo = 'Premium-1';
--usuarios que más viajan, que tengan tarjeta tipo 'Estandar' y que sean menores de 40 años y su fecha de adquisición de la tarjeta 
SELECT  u.usuario_id, u.nombre, u.fecha_nacimiento, t.fecha_adquisicion,
COUNT(v.viaje_id) AS total_viajes FROM usuarios u
JOIN tarjetas t ON u.usuario_id = t.usuario_id
JOIN viajes v ON t.tarjeta_id = v.tarjeta_id
WHERE t.tipo = 'Estandar' AND DATE_PART('year', AGE(CURRENT_DATE, u.fecha_nacimiento)) < 40
GROUP BY u.usuario_id, u.nombre, u.fecha_nacimiento, t.fecha_adquisicion
ORDER BY total_viajes DESC;

--Consulta Estudiantes que  mas  viajes hacen  y su fecha de adquisición de la tarjeta
SELECT u.usuario_id, u.nombre, COUNT(v.viaje_id) AS total_viajes
FROM usuarios u JOIN tarjetas t ON u.usuario_id = t.usuario_id
JOIN viajes v ON t.tarjeta_id = v.tarjeta_id
WHERE t.tipo = 'Estudiantes' GROUP BY u.usuario_id, u.nombre
ORDER BY total_viajes DESC;

--Consulta para saber quienes son los mas mayores y tienen tarjeta estándar  y fecha de adquisición 
SELECT u.usuario_id, u.nombre, u.fecha_nacimiento, t.tipo, t.fecha_adquisicion
FROM usuarios u JOIN tarjetas t ON u.usuario_id = t.usuario_id
WHERE t.tipo = 'Estandar'
ORDER BY u.fecha_nacimiento ASC;


