--IMPORTACIONES

CREATE TABLE proveedor(
	id_proveedor		SERIAL,
	nombre			VARCHAR(50) NOT NULL,
	nacionalidad		VARCHAR(30) NOT NULL,
	info_contacto		TEXT NOT NULL,

	PRIMARY KEY (id_proveedor)
);


CREATE TABLE importacion (
	id_importacion		SERIAL,
	cuota_arancelaria	NUMERIC(6,2) NOT NULL,
	fecha_recepcion		DATE NOT NULL,
	total      		NUMERIC(6,2) NOT NULL,

	PRIMARY KEY (id_importacion)
);


CREATE TABLE pedido (
	id_pedido		SERIAL,
	proveedor_id 		SERIAL	NOT NULL,
	importacion_id   	SERIAL	NOT NULL,
	empleado_id 		INTEGER	NOT NULL,
	fecha_pedido		DATE	NOT NULL,
	fecha_recepcion		DATE	NOT NULL,
	total 			NUMERIC(6,2) NOT NULL,

    PRIMARY KEY (id_pedido),
    FOREIGN KEY (PROVEEDOR_proveedor_id) 	REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (IMPORTACION_importacion_id) 	REFERENCES importacion(id_importacion),
    FOREIGN KEY (EMPLEADO_empleado_id) 		REFERENCES empleado(id_empleado)

);



CREATE TABLE producto_pedido(
	id_producto 	SERIAL,
	producto_id 	SERIAL,
	pedido_id	SERIAL,
	costo   	NUMERIC(6,2) NOT NULL,

	PRIMARY KEY (id_producto),
	FOREIGN KEY (PRODUCTO_producto_id) 	REFERENCES producto(id_producto),
      	FOREIGN KEY (PEDIDO_pedidio_id) 	REFERENCES pedido(id_pedido)
);


CREATE TABLE producto(
	id_producto 	SERIAL,
	nombre 		VARCHAR(50) NOT NULL,
	descripcion 	VARCHAR(80) NOT NULL,
	unidad 		INTEGER NOT NULL,
	
	PRIMARY KEY (id_producto)
);
