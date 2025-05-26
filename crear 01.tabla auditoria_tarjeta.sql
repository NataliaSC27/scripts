CREATE TABLE auditoria_tarjeta(
    auditoria_id INT PRIMARY KEY,
    tarjeta_id INT,
    estado_anterior VARCHAR(50),
    estado_nuevo VARCHAR(50),
    fecha_cambio DATE,
    FOREIGN KEY (tarjeta_id) REFERENCES TARJETAS(tarjeta_id)
);
