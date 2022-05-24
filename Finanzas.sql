CREATE TABLE FACTURA (

	folio_factura SERIAL NOT NULL PRIMARY KEY,
	fecha_emision DATE NOT NULL,
	lugar_emision VARCHAR(50) NOT NULL,
	venta_id INTEGER REFERENCES VENTA(manufactura_id)

);
