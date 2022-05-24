-- CREAR BASE DE DATOS

CREATE DATABASE BDII_PROYECTO;

\c bdii_proyecto

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
	empleado_id			INTEGER	 NOT NULL,

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
	FOREIGN KEY(departamento_id) REFERENCES direccion(id_direccion)
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
