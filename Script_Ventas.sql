
CREATE TABLE venta(
manufactura_id  INTEGER NOT NULL,
cliente_id           INTEGER NOT NULL,    
empleado_id     INTEGER NOT NULL,
fecha      DATE NOT NULL,
PRIMARY KEY (manufactura_id) , 
FOREIGN KEY (cliente_id, empleado_id) ;

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
