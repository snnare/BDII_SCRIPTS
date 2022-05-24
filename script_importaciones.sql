--IMPORTACIONES

CREATE TABLE proveedor(
	id_proveedor		SERIAL 		NOT NULL,
	nombre				VARCHAR(50) NOT NULL,
	nacionalidad		VARCHAR(30) NOT NULL,
	info_contacto		TEXT NOT NULL,

	PRIMARY KEY (id_proveedor)
);


CREATE TABLE importacion (
	id_importacion		SERIAL		 NOT NULL,
	cuota_arancelaria	NUMERIC(6,2) NOT NULL,
	fecha_recepcion		DATE 		 NOT NULL,
	total      			NUMERIC(6,2) NOT NULL,

	PRIMARY KEY (id_importacion)
);


CREATE TABLE pedido (
	id_pedido			SERIAL	 	NOT NULL,
	proveedor_id 		SERIAL	 	NOT NULL,
	importacion_id   	SERIAL	 	NOT NULL,
	rfc					VARCHAR(13) NOT NULL,
	empleado_id 		INTEGER	 	NOT NULL,
	fecha_pedido		DATE	 	NOT NULL,
	fecha_recepcion		DATE	 	NOT NULL,
	total 				NUMERIC(6,2)NOT NULL,

    PRIMARY KEY (id_pedido),
    FOREIGN KEY (proveedor_id) 		REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (importacion_id) 	REFERENCES importacion(id_importacion),
    FOREIGN KEY (rfc, empleado_id) 	REFERENCES empleado(rfc, id_empleado)

);



CREATE TABLE producto(
	id_producto 		SERIAL			NOT NULL,
	nombre 				VARCHAR(50) 	NOT NULL,
	descripcion 		TEXT 			NOT NULL,
	unidad 				INTEGER 		NOT NULL,
	
	PRIMARY KEY (id_producto)
);

CREATE TABLE producto_pedido(
	id_producto_pedido 		SERIAL 			NOT NULL,
	producto_id 			SERIAL 			NOT NULL,
	pedido_id				SERIAL 			NOT NULL,
	costo   				NUMERIC(6,2) 	NOT NULL,

	PRIMARY KEY (id_producto_pedido),
	FOREIGN KEY (producto_id) 	REFERENCES producto(id_producto),
    FOREIGN KEY (pedido_id) 	REFERENCES pedido(id_pedido)
);

