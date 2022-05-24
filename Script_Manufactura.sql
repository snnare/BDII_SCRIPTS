--------------------------------------------------------------------------
-- CREACIÓN TABLAS
-- ÁREA MANUFACTURA
---------------------------------------------------------------------------

-- En los atributos "id's" si se ponen como tipo SERIAL son autoincrementales
-- Pero en PGAdmin marcó error a la hora de querer hacer un insert 
-- el atributo "Cantidad" se puso como INT por suponer que no serán más de 250

CREATE TABLE IF NOT EXISTS solicitud
(
	id_solicitud 		INTEGER 	NOT NULL,
	id_producto 		INTEGER 	NOT NULL,
	fecha 			DATE		NOT NULL,
	cantidad 		INTEGER,
	id_manufactura 		INTEGER 	NOT NULL,

	PRIMARY KEY (id_solicitud),
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
	FOREIGN KEY (id_manufactura) REFERENCES manufactura(id_manufactura)
);

-- En esta tabla el atributo "tipo" se detallará graficamente a la hora de hacer
-- registros
-- Tipo: 1. Casa, 2. Cocina Integral, 3. Baño
-- Y será lo mismo con el atributo "Status"
-- Status: 1. En Obra, 2. En Venta, 3. En Renta, 4. Vendida, 5. Rentada, 6. Deteri
-- Y finalmente, ambos atributos de "costos" Se puso el tipo DECIMAL
-- Ya que no se conoce el precio de los productos, o mano de obra
-- Por lo que no se sabe cuantos enteros o decimales tendrá la cantidad

CREATE TABLE IF NOT EXISTS manufactura
(
	id_manufactura 		INTEGER 	NOT NULL, 
	id_direccion 		INTEGER		NOT NULL,
	tipo 			INTEGER,
	fecha_inicio 		DATE		NOT NULL,
	fecha_termino 		DATE,
	id_outsourcing 		INTEGER 	NOT NULL,
	costo_obra 		NUMERIC,
	costo_total 		NUMERIC, 
	status 			INTEGER,

	PRIMARY KEY (id_manufactura),
	FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
	FOREIGN KEY (id_outsourcing) REFERENCES outsourcing(id_outsourcing)
);

-- El atributo "Cantidad" se puso como INT por suponer que no serán más de 250

CREATE TABLE IF NOT EXISTS sobrante
(
	id_producto 		INTEGER 	NOT NULL,
	id_manufactura 		INTEGER 	NOT NULL,
	cantidad 		INTEGER,

	PRIMARY KEY (id_producto, id_manufactura),
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
	FOREIGN KEY (id_manufactura) REFERENCES manufactura(id_manufactura)
);

-- IDK

CREATE TABLE IF NOT EXISTS outsourcing
(
	id_outsourcing 		INTEGER 	NOT NULL,
	empresa 		VARCHAR(50), 
	costo 			NUMERIC 	NOT NULL,
	contrato 		PATH, "/Documentos/contrato0234.pdf"

	PRIMARY KEY(id_outsourcing)
);

-- El atributo fecha_termino es opcional
-- El atrbituo status se explicará graficamente:
-- Status: 1. En mantenimiento, 2. Finalizado

CREATE TABLE IF NOT EXISTS mantenimiento
(
	id_mantenimiento 	INTEGER 	NOT NULL,
	id_manufactura 		INTEGER 	NOT NULL, 
	id_defecto 		INTEGER,
	fecha_inicio 		DATE,
	fecha_termino 		DATE,
	costo 			NUMERIC,
	status 			INTEGER,

	PRIMARY KEY (id_mantenimiento),
	FOREIGN KEY (id_manufactura) REFERENCES manufactura(id_manufactura),
	FOREIGN KEY (id_defecto) REFERENCES defecto(id_defecto)
);

-- En esta tabla el atributo "tipo" hace referencia a que si es un detalle:
-- 1. Estructural
-- 2. 
-- 3. 
-- Etc, por lo que se optó por poner el atributo como tipo INTEGER
-- Y especificar graficamente cuales son las posibles opciones

CREATE TABLE IF NOT EXISTS defecto
(
	id_defecto 		INTEGER 	NOT NULL,
	tipo 			INTEGER,
	descripcion 		TEXT,

	PRIMARY KEY (id_defecto)
);
