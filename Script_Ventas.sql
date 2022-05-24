
CREATE TABLE venta(
manufactura_id  INTEGER NOT NULL,
cliente_id       VARCHAR(13) NOT NULL,
rfc VARCHAR (15 ) NOT NULL,
empleado_id     INTEGER NOT NULL,
fecha      DATE NOT NULL,
PRIMARY KEY (manufactura_id) , 
FOREIGN KEY (rfc, empleado_id) REFERENCES empleado (rfc , id_empleado),
FOREIGN KEY (cliente_id) REFERENCES cliente (rfc) ;

CREATE TABLE cliente (
rfc VARCHAR (15 ),
genero   INTEGER,
PRIMARY KEY (rfc), INHERITS (persona);



CREATE TABLE factura (
folio_factura INTEGER NOT NULL,
venta_id INTEGER,
fecha_emision DATE NOT NULL, 
lugar_emision VARCHAR (15),
PRIMARY KEY (folio_factura);
