-- Tabla Dispositivos
CREATE TABLE dispositivos ( dispositivo_id SERIAL PRIMARY KEY,
tipo VARCHAR(50) NOT NULL,
fecha_instalacion DATE );

-- Tabla Validaciones
CREATE TABLE validaciones (
    validacion_id SERIAL PRIMARY KEY,
    viaje_id INT REFERENCES viajes(viaje_id),
    dispositivo_id INT REFERENCES dispositivos(dispositivo_id),
    fecha DATE NOT NULL );
