--Modificacion 
ALTER TABLE recargas ADD COLUMN medio_id INT;
ALTER TABLE recargas ADD CONSTRAINT fk_medio_pago FOREIGN KEY (medio_id) REFERENCES medios_pago(medio_id);
