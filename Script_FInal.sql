--------------------------- RH
CREATE TABLE direccion(
	id_direccion			SERIAL NOT NULL,
	cp						VARCHAR(5)  NOT NULL,
	entidad_federativa		VARCHAR(30) NOT NULL, 
	localidad				VARCHAR(40) NOT NULL,
	colonia					VARCHAR(50) NOT NULL,
	calle					VARCHAR(50) NOT NULL,
	numero_ext				INTEGER,
	numero_int				INTEGER,
	cedula_catastral		VARCHAR(20),

	PRIMARY KEY (id_direccion)
);


CREATE TABLE persona (
	rfc				VARCHAR(13) NOT NULL,
	nombre			VARCHAR(50) NOT NULL,
	apellido1		VARCHAR(50) NOT NULL,
	apellido2       VARCHAR(50) NOT NULL,
	telefono		VARCHAR(10) NOT NULL,
	email_persona   VARCHAR(45),
	direccion_id	SERIAL		NOT NULL,

	PRIMARY KEY (rfc),
	FOREIGN KEY (direccion_id) REFERENCES direccion(id_direccion)
);


CREATE TABLE empleado (
	id_empleado			INTEGER 	NOT NULL,
	cuenta_bancaria 	INTEGER 	NOT NULL,
	nss					VARCHAR(11) NOT NULL,
	fecha_nacimiento	DATE 		NOT NULL,
	cv					VARCHAR(40) NOT NULL, -- PATH donde se encuentra el archivo
	email_trabajo		VARCHAR(50) NOT NULL,
	licencia 			INTEGER,
    
    PRIMARY KEY (rfc, id_empleado)
)INHERITS (persona);



CREATE TABLE nomina(
	id_nomina 		SERIAL		 NOT NULL,
	rfc				VARCHAR(13)	 NOT NULL,
	empleado_id 	INTEGER 	 NOT NULL,
	fecha_inicio	DATE 		 NOT NULL,
	fecha_corte		DATE    	 NOT NULL,
	salario_bruto   NUMERIC(6,2) NOT NULL,
	isr				NUMERIC(3,2) NOT NULL,
	salario_neto	NUMERIC(6,2) NOT NULL,

	PRIMARY KEY (id_nomina),
	FOREIGN KEY (rfc, empleado_id) REFERENCES empleado(rfc, id_empleado)
);


CREATE TABLE dependiente_economico(
	id_dependiente_economico	SERIAL 		 NOT NULL,
	parentesco					VARCHAR(40)  NOT NULL,
	nombre_completo				VARCHAR(100) NOT NULL,
	telefono					VARCHAR(10)  NOT NULL,
	rfc							VARCHAR(13)	 NOT NULL,
	empleado_id					INTEGER      NOT NULL,

	PRIMARY KEY(id_dependiente_economico),
	FOREIGN KEY(rfc, empleado_id) REFERENCES empleado(rfc, id_empleado)
);

CREATE TABLE prestacion(
	id_prestacion	INTEGER 	 NOT NULL,
	nombre 			VARCHAR(40)	 NOT NULL,
	tipo			VARCHAR(30)  NOT NULL,
	descripcion		TEXT		 NOT NULL,
	duracion 		VARCHAR(20)  NOT NULL,
	monto  			NUMERIC(6,2) NOT NULL,

	PRIMARY KEY(id_prestacion)
);

CREATE TABLE prestacion_emp(
	rfc				VARCHAR(13) NOT NULL,
	empleado_id		INTEGER 	NOT NULL,
	prestacion_id	INTEGER 	NOT NULL,
	fecha_inicio    DATE    	NOT NULL,
	fecha_corte     DATE,

	PRIMARY KEY (rfc, empleado_id, prestacion_id, fecha_inicio),
	FOREIGN KEY(rfc, empleado_id) REFERENCES empleado(rfc, id_empleado),
	FOREIGN KEY(prestacion_id) REFERENCES prestacion(id_prestacion)
);

CREATE TABLE turno(
	id_turno     	INTEGER NOT NULL,
	hora_entrada	TIME	NOT NULL,-- TIME almacena la hora del dia en que se inserto
	hora_salida		TIME 	NOT NULL,

	PRIMARY KEY(id_turno)
);


CREATE TABLE jornada_emp(
	rfc				VARCHAR(13) 	NOT NULL,
	empleado_id 	INTEGER			NOT NULL,
	fecha_inicio	DATE    		NOT NULL,
	fecha_termino   DATE,
	turno_id        INTEGER 		NOT NULL, 

	PRIMARY KEY (rfc, empleado_id, fecha_inicio),
	FOREIGN KEY (rfc, empleado_id) 	REFERENCES empleado(rfc, id_empleado),
	FOREIGN KEY (turno_id)	  		REFERENCES turno(id_turno)
);


CREATE TABLE curso(
	id_curso			SERIAL   	NOT NULL,
	descripcion    		TEXT     	NOT NULL,
	duracion_horas		INTEGER  	NOT NULL,
	rfc					VARCHAR(13) NOT NULL,
	empleado_id			INTEGER	 	NOT NULL,

	PRIMARY KEY (id_curso),
	FOREIGN KEY (rfc, empleado_id) REFERENCES empleado(rfc, id_empleado)
);

CREATE TABLE capacitacion(
	curso_id		SERIAL   		NOT NULL,
	rfc				VARCHAR(13)	 	NOT NULL,
	empleado_id		INTEGER	 		NOT NULL,
	fecha           DATE     		NOT NULL,

	PRIMARY KEY(curso_id, rfc, empleado_id),
	FOREIGN KEY(curso_id) REFERENCES curso (id_curso),
	FOREIGN KEY(rfc, empleado_id) REFERENCES empleado(rfc, id_empleado)
);


CREATE TABLE evaluacion(
	rfc				 VARCHAR(13)	NOT NULL,
	empleado_id		 INTEGER 		NOT NULL,	
	fecha 			 DATE    		NOT NULL,    
	rating			 VARCHAR(30)	NOT NULL,
	observaciones    TEXT,

	PRIMARY KEY(rfc, empleado_id, fecha),
	FOREIGN KEY(rfc, empleado_id) REFERENCES empleado (rfc, id_empleado)
);


CREATE TABLE departamento(
	id_departamento   	SERIAL 		NOT NULL,
	nombre 				VARCHAR(30) NOT NULL,
	descripcion			TEXT		NOT NULL,
	PRIMARY KEY (id_departamento)
);

CREATE TABLE cargo(
	id_cargo			INTEGER		NOT NULL,
	nombre  			VARCHAR(40) NOT NULL,
	descripcion     	TEXT		NOT NULL,
	departamento_id     SERIAL 		NOT NULL,

	PRIMARY KEY(id_cargo),
	FOREIGN KEY(departamento_id) REFERENCES departamento(id_departamento)
);

CREATE TABLE contrato(
	rfc					VARCHAR(13)	NOT NULL,
	empleado_id			INTEGER 	NOT NULL,
	fecha_inicio		DATE 		NOT NULL,
	fecha_termino		DATE 		NOT NULL,
	tipo				VARCHAR(20)	NOT NULL,
	cargo_id		    INTEGER		NOT NULL,

	PRIMARY KEY(rfc, empleado_id, fecha_inicio),
	FOREIGN KEY(rfc, empleado_id) REFERENCES empleado (rfc, id_empleado),
	FOREIGN KEY(cargo_id) REFERENCES cargo(id_cargo)
);

CREATE TABLE salario(
	id_salario			SERIAL			NOT NULL, -- Poner restricciones , revisar
	fecha_inicio		DATE 			NOT NULL,
	salario_base		NUMERIC(6,2)	NOT NULL,

	PRIMARY KEY(id_salario)
);


CREATE TABLE oficina(
	id_oficina			INTEGER  	NOT NULL,
	departamento_id     SERIAL 	 	NOT NULL,
	direccion_id		SERIAL   	NOT NULL,
	nombre   			VARCHAR(30)	NOT NULL,
	capacidad			INTEGER 	NOT NULL,

	PRIMARY KEY(id_oficina),
	FOREIGN KEY(departamento_id) REFERENCES departamento(id_departamento),
	FOREIGN KEY(direccion_id) REFERENCES direccion(id_direccion)
);

CREATE TABLE acceso(
	rfc					VARCHAR(13)	NOT NULL,
	empleado_id			INTEGER 	NOT NULL,
	fecha_hora_in		TIMESTAMP	NOT NULL,
	fecha_hora_out		TIMESTAMP   NOT NULL,
	tipo				VARCHAR(20) NOT NULL,
	oficina_id          INTEGER		NOT NULL,

	PRIMARY KEY(rfc, empleado_id, fecha_hora_in),
	FOREIGN KEY(rfc, empleado_id) REFERENCES empleado(rfc, id_empleado),
	FOREIGN KEY(oficina_id) REFERENCES oficina (id_oficina)
);

CREATE TABLE candidato(
	id_candidato 		SERIAL NOT NULL,
	curp				VARCHAR(18) NOT NULL,
	anios_experiencia	INTEGER		NOT NULL,
	grados_estudio		VARCHAR(40) NOT NULL,
	fecha_nacimiento	DATE,
	cv					VARCHAR(40) NOT NULL,

	PRIMARY KEY (rfc, id_candidato)

) INHERITS (persona);

CREATE TABLE vacante (
	id_vacante				SERIAL 			NOT NULL,
	cargo_id				INTEGER			NOT NULL,
	fecha_apertura			DATE 			NOT NULL,
	estudios_requeridos		VARCHAR(30)		NOT NULL,
	experiencia_requerida   INTEGER 		NOT NULL,
	status 					VARCHAR(20)		NOT NULL,

	PRIMARY KEY(id_vacante),
	FOREIGN KEY(cargo_id) REFERENCES cargo(id_cargo)
);

CREATE TABLE postulacion(
	rfc					VARCHAR(13)		NOT NULL,
	candidato_id	  	SERIAL 			NOT NULL,
	vacante_id			SERIAL 			NOT NULL,
	rating				INTEGER			NOT NULL,		
	status				VARCHAR(30)		NOT NULL,

	PRIMARY KEY (rfc, candidato_id, vacante_id),
	FOREIGN KEY (rfc, candidato_id) REFERENCES candidato(rfc, id_candidato),
	FOREIGN KEY (vacante_id) REFERENCES vacante(id_vacante)
);


--------------------------- RUTAS
CREATE TABLE ruta(
    id_ruta         SERIAL      NOT NULL,
    nombre          VARCHAR(20) NOT NULL,
    descripcion     TEXT        NOT NULL,
    duracion_aprox  INTEGER     NOT NULL, --- Numero de horas

    PRIMARY KEY (id_ruta)
);


CREATE TABLE parada(
    ruta_id             SERIAL      NOT NULL,
    numero_parada       SERIAL      NOT NULL,
    direccion_id        SERIAL      NOT NULL,

    PRIMARY KEY(ruta_id , numero_parada),
    FOREIGN KEY(ruta_id)   REFERENCES ruta(id_ruta),
    FOREIGN KEY(direccion_id) REFERENCES direccion (id_direccion)
);

CREATE TABLE autobus(
    placas              VARCHAR(20)     NOT NULL,
    numero_asientos     INTEGER         NOT NULL,
    status              VARCHAR(20)     NOT NULL,

    PRIMARY KEY (placas)
);

CREATE TABLE mantenimiento_autobus(
    autobus_id          VARCHAR(20)     NOT NULL,
    fecha               DATE            NOT NULL,
    descripcion         TEXT            NOT NULL,
    proveedor           VARCHAR(20)     NOT NULL,
    costo               NUMERIC(6,2)    NOT NULL,

    PRIMARY KEY (autobus_id,  fecha),
    FOREIGN KEY(autobus_id) REFERENCES autobus(placas)
);


CREATE TABLE  viaje (
    id_viaje                    SERIAL          NOT NULL,
    autobus_id                  VARCHAR(20)     NOT NULL,
    ruta_id                     SERIAL          NOT NULL,
    rfc                         VARCHAR(13)     NOT NULL,
    empleado_id                 INTEGER         NOT NULL,
    kilometraje_inicial         NUMERIC(5,2)    NOT NULL,
    kilometraje_final           NUMERIC(5,2)    NOT NULL,   
    fecha_hora_salida           TIMESTAMP       NOT NULL,
    viaticos                    NUMERIC(5,2)    NOT NULL,

    PRIMARY KEY(id_viaje),
    FOREIGN KEY (autobus_id) REFERENCES autobus  (placas),
    FOREIGN KEY (ruta_id)   REFERENCES ruta(id_ruta),
    FOREIGN KEY (rfc, empleado_id) REFERENCES empleado (rfc, id_empleado)
);

CREATE TABLE viaje_emp(
	viaje_id			SERIAL 			NOT NULL,
	rfc					VARCHAR(13)		NOT NULL,
	empleado_id			INTEGER			NOT NULL,

	PRIMARY KEY (viaje_id, rfc, empleado_id),
	FOREIGN KEY (viaje_id) REFERENCES viaje(id_viaje),
	FOREIGN KEY (rfc, empleado_id) REFERENCES empleado (rfc, id_empleado)
);


--------------------------- IMPORTACIONES

CREATE TABLE proveedor(
	id_proveedor		SERIAL 		NOT NULL,
	nombre				VARCHAR(50) NOT NULL,
	nacionalidad		VARCHAR(30) NOT NULL,
	info_contacto		TEXT 		NOT NULL,

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


----------------- MANUFACUTRA

CREATE TABLE IF NOT EXISTS defecto
(
	id_defecto 		INTEGER 	NOT NULL,
	tipo 			INTEGER,
	descripcion 		TEXT,

	PRIMARY KEY (id_defecto)
);


CREATE TABLE IF NOT EXISTS outsourcing(
	id_outsourcing 		INTEGER 	NOT NULL,
	empresa 			VARCHAR(50) NOT NULL, 
	costo 				NUMERIC 	NOT NULL,
	contrato 			PATH, 

	PRIMARY KEY(id_outsourcing)
);


CREATE TABLE IF NOT EXISTS manufactura
(
	id_manufactura 		INTEGER 	NOT NULL, 
	direccion_id 		SERIAL		NOT NULL,
	tipo 				INTEGER		NOT NULL,
	fecha_inicio 		DATE		NOT NULL,
	fecha_termino 		DATE,
	outsourcing_id 		INTEGER 	NOT NULL,
	costo_obra 			NUMERIC		NOT NULL,
	costo_total 		NUMERIC		NOT NULL, 
	status 				INTEGER		NOT NULL,

	PRIMARY KEY (id_manufactura),
	FOREIGN KEY (direccion_id) REFERENCES direccion(id_direccion),
	FOREIGN KEY (outsourcing_id) REFERENCES outsourcing(id_outsourcing)
);


CREATE TABLE IF NOT EXISTS mantenimiento
(
	id_mantenimiento 	INTEGER 	NOT NULL,
	manufactura_id 		INTEGER 	NOT NULL, 
	defecto_id 			INTEGER		NOT NULL,
	fecha_inicio 		DATE		NOT NULL,
	fecha_termino 		DATE,
	costo 				NUMERIC,
	status 				INTEGER,

	PRIMARY KEY (id_mantenimiento),
	FOREIGN KEY (manufactura_id) REFERENCES manufactura(id_manufactura),
	FOREIGN KEY (defecto_id) REFERENCES defecto(id_defecto)
);




CREATE TABLE IF NOT EXISTS solicitud
(
	id_solicitud 		INTEGER 	NOT NULL,
	producto_id 		INTEGER 	NOT NULL,
	fecha 				DATE		NOT NULL,
	cantidad 			INTEGER		NOT NULL,
	manufactura_id 		INTEGER 	NOT NULL,

	PRIMARY KEY (id_solicitud),
	FOREIGN KEY (producto_id) REFERENCES producto(id_producto),
	FOREIGN KEY (manufactura_id) REFERENCES manufactura(id_manufactura)
);



CREATE TABLE IF NOT EXISTS sobrante
(
	producto_id 		INTEGER 	NOT NULL,
	manufactura_id 		INTEGER 	NOT NULL,
	cantidad 			INTEGER		NOT NULL,

	PRIMARY KEY (producto_id, manufactura_id),
	FOREIGN KEY (producto_id) REFERENCES producto(id_producto),
	FOREIGN KEY (manufactura_id) REFERENCES manufactura(id_manufactura)
);

-------- --------- VENTAS

CREATE TABLE cliente(
	genero    INTEGER,
	PRIMARY KEY (rfc) 
) INHERITS (persona);



CREATE TABLE venta(
	manufactura_id       INTEGER 		NOT NULL,
	cliente_id           VARCHAR(13) 	NOT NULL,    
	rfc                  VARCHAR(13) 	NOT NULL,
	empleado_id          INTEGER 		NOT NULL,
	fecha                DATE 			NOT NULL,

	PRIMARY KEY (manufactura_id) , 
	FOREIGN KEY (rfc, empleado_id) REFERENCES empleado (rfc , id_empleado),
	FOREIGN KEY (cliente_id) REFERENCES cliente (rfc)
) ;


----------------- FINANZAS
CREATE TABLE FACTURA (
	folio_factura 		SERIAL 		NOT NULL,
	fecha_emision 		DATE 		NOT NULL,
	lugar_emision 		VARCHAR(50) NOT NULL,
	venta_id 			INTEGER 	NOT NULL REFERENCES VENTA(manufactura_id),

	PRIMARY KEY (folio_factura),
	FOREIGN KEY (venta_id) REFERENCES venta (manufactura_id)
);


------ CONTROL INVENTARIOS

CREATE TABLE PAGO_RENTA(
    id_renta            SERIAL          NOT NULL,
    fecha_inicio        DATE            NOT NULL,
    fecha_termino       DATE            NOT NULL,
    costo               NUMERIC(6,2)    NOT NULL,
    PRIMARY KEY (id_renta, fecha_inicio)    
);


CREATE TABLE BODEGA(
    id_bodega       SERIAL        NOT NULL,
    tamanio         VARCHAR(20)   NOT NULL,
    capacidad       VARCHAR(20)   NOT NULL,
    direccion_id    SERIAL        NOT NULL,

    PRIMARY KEY (id_bodega),
    FOREIGN KEY (direccion_id) REFERENCES direccion(id_direccion)
);


CREATE TABLE RENTA(
    id_renta            SERIAL                  NOT NULL,
    bodega_id           SERIAL                  NOT NULL,
    fecha_contratacion  DATE                    NOT NULL,
    fecha_termino       DATE                    NOT NULL,
    provedor            VARCHAR(50)             NOT NULL,
    deposito            NUMERIC(6,2)            NOT NULL,
    
    PRIMARY KEY (id_renta),
    FOREIGN KEY (bodega_id) REFERENCES bodega (id_bodega)
    
    );


CREATE TABLE MOV_SALIDA(
    id_mov_salida       	 SERIAL 		 NOT NULL,
    fecha_hora_envio         TIMESTAMP       NOT NULL,
    fecha_hora_recepcion     TIMESTAMP       NOT NULL,
    manufactura_id      	 INTEGER         NOT NULL,
	
	 PRIMARY KEY(id_mov_salida),
	 FOREIGN KEY(manufactura_id) REFERENCES manufactura (id_manufactura)
);


CREATE TABLE INVENTARIO(
	producto_pedido_id  	 INT     	  NOT NULL,
	bodega_id           	 INT     	  NOT NULL,
	fecha_hora_entrada       TIMESTAMP    NOT NULL,
	fecha_hora_salida        TIMESTAMP    NOT NULL,
	mov_salida_id      		 SERIAL 	  NOT NULL,
	
    PRIMARY KEY(producto_pedido_id),
    FOREIGN KEY(producto_pedido_id) REFERENCES producto_pedido(id_producto_pedido),
	FOREIGN KEY (bodega_id) REFERENCES bodega (id_bodega),
	FOREIGN KEY (mov_salida_id) REFERENCES mov_salida (id_mov_salida)
);

------------- MARKETING
CREATE TABLE promocion (
	id_promocion 	INTEGER 		 	NOT NULL,
	nombre 			VARCHAR(50) 		NOT NULL,
	descripcion  	TEXT 				NOT NULL,
	tipo 			VARCHAR(30) 		NOT NULL,

	PRIMARY KEY(id_promocion)
);


CREATE TABLE promocion_man (
	promocion_id 			INTEGER  	NOT NULL,
	manufactura_id   		INTEGER  	NOT NULL,  					                          
	fecha_inicio 			DATE 		NOT NULL,
	fecha_termino			DATE 		NOT NULL,
	descuento 				NUMERIC		NOT NULL,

	PRIMARY KEY (promocion_id, manufactura_id),
	FOREIGN KEY (promocion_id) REFERENCES promocion (id_promocion),
	FOREIGN KEY (manufactura_id) REFERENCES manufactura (id_manufactura)
	
);

CREATE TABLE campania (
	id_campania 		INTEGER 	NOT NULL,
	fecha_inicio 		DATE 		NOT NULL,
	fecha_termino 		DATE 		NOT NULL,
	audiencia 			VARCHAR(30) NOT NULL,
	region 				VARCHAR(30) NOT NULL,
	--promocion_id 		INTEGER 	NOT NULL,
	
	PRIMARY KEY(id_campania)
	--FOREIGN KEY (promocion_id) REFERENCES promocion (id_promocion)
);


CREATE TABLE anuncio (
	id_anuncio			INTEGER			NOT NULL,
	campania_id 		INTEGER  		NOT NULL,
	contacto 			VARCHAR(50) 	NOT NULL,
	proveedor 			VARCHAR(50) 	NOT NULL,
	costo 				NUMERIC(20,2)	NOT NULL,
	promocion_man_id 	INTEGER 		NOT NULL,
	
	PRIMARY KEY (id_anuncio),
	FOREIGN KEY (campania_id) REFERENCES campania (id_campania),
	FOREIGN KEY (promocion_man_id) REFERENCES promocion_man (promocion_id, manufactura_id)
	);


CREATE TABLE ad_fisico (
	fecha_inicio 	DATE 		NOT NULL,
	fecha_termino 	DATE 		NOT NULL,
	ubicacion 		VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_anuncio)
)INHERITS(anuncio);



CREATE TABLE ad_web (
	fecha_inicio 	DATE 			NOT NULL,
	fecha_termino	DATE 			NOT NULL,
	tipo 			VARCHAR(50)  	NOT NULL ,
	url 			VARCHAR(100)  	NOT NULL, 
	PRIMARY KEY (id_anuncio)
)INHERITS(anuncio);


CREATE TABLE ad_broadcast (
	fecha_hora 			DATE   NOT NULL,
	broadcast_channel 	VARCHAR(30),

	PRIMARY KEY (id_anuncio)
)INHERITS(anuncio);

------------------------USUARIOS
CREATE TABLE usuariosclientes (
|	rfc 			VARCHAR(13) NOT NULL,
|	contrasenia 	VARCHAR(50) NOT NULL,

	PRIMARY KEY (rfc)
);

CREATE TABLE usuariosempleados (
	rfc 			VARCHAR(13) NOT NULL,
	contrasenia 	VARCHAR(50) NOT NULL,

	PRIMARY KEY (rfc)
);

CREATE TABLE usuariosadmin (
	rfc 			VARCHAR(13) not null,
	contrasenia 	VARCHAR(50) not null,

	PRIMARY KEY (rfc)
);
