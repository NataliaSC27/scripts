ALTER TABLE recargas 
ADD COLUMN promociones_id INTEGER;

ALTER TABLE recargas
ADD CONSTRAINT fk_recargas_promociones
FOREIGN KEY (promociones_id) REFERENCES promociones(promociones_id);
