-- CREAR BASE DE DATOS

CREATE DATABASE BDII_PROYECTO;

\c bdii_proyecto

CREATE TABLE direccion(
	id_direccion			SERIAL,
	cp						VARCHAR(5) NOT NULL,
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
	direccion_id	SERIAL,

	PRIMARY KEY (rfc),
	FOREIGN KEY (direccion_id) REFERENCES direccion(id_direccion)
);


-- RH

-- En esta tabla tenemos una PRIMARY KEY compuesta por (RFC, id_empleado)
-- no obstante si la creamos como tal PRIMARY KEY(rfc, id_empleado) al momento
-- de crear las demas tablas donde id_empleado es una FOREING KEY no nos deja
CREATE TABLE empleado (
	id_empleado			INTEGER 	NOT NULL,
	cuenta_bancaria 	VARCHAR(20) NOT NULL,
	nss					VARCHAR(11) NOT NULL,
	fecha_nacimiento	DATE 		NOT NULL,
	cv					VARCHAR(40) NOT NULL, -- PATH donde se encuentra el archivo
	email_trabajo		VARCHAR(45) NOT NULL,
	licencia 			VARCHAR(15),
    
    PRIMARY KEY (id_empleado)

)INHERITS (persona);



CREATE TABLE nomina(
	id_nomina 		SERIAL,
	empleado_id 	INTEGER 	 NOT NULL,
	fecha_inicio	DATE 		 NOT NULL,
	fecha_corte		DATE    	 NOT NULL,
	salario_bruto   NUMERIC(6,2) NOT NULL,
	isr				NUMERIC(3,2) NOT NULL,
	salario_neto	NUMERIC(6,2) NOT NULL,

	PRIMARY KEY (id_nomina),
	FOREIGN KEY (empleado_id) REFERENCES empleado(id_empleado)
);


CREATE TABLE dependiente_economico(
	id_dependiente_economico	SERIAL,
	parentesco					VARCHAR(40)  NOT NULL,
	nombre_completo				VARCHAR(100) NOT NULL,
	telefono					VARCHAR(10)  NOT NULL,
	empleado_id					INTEGER      NOT NULL,

	PRIMARY KEY(id_dependiente_economico),
	FOREIGN KEY(empleado_id) REFERENCES empleado(id_empleado)
);

CREATE TABLE prestacion(
	id_prestacion	INTEGER 	 NOT NULL,
	nombre 			VARCHAR(40)	 NOT NULL,
	tipo			VARCHAR(30)  NOT NULL,
	descripcion		TEXT		 NOT NULL,
	duracion 		DATE  		 NOT NULL,
	monto  			NUMERIC(6,2) NOT NULL,

	PRIMARY KEY(id_prestacion)
);

-- Tabla pivote
CREATE TABLE prestacion_emp(
	empleado_id		INTEGER 	NOT NULL,
	prestacion_id	INTEGER 	NOT NULL,
	fecha_inicio    DATE    	NOT NULL,
	fecha_corte     DATE,

	PRIMARY KEY (empleado_id, prestacion_id, fecha_inicio),
	FOREIGN KEY(empleado_id) REFERENCES empleado(id_empleado),
	FOREIGN KEY(prestacion_id) REFERENCES prestacion(id_prestacion)
);


CREATE TABLE turno(
	id_turno     	INTEGER NOT NULL,
	hora_entrada	TIME	NOT NULL,-- TIME almacena la hora del dia en que se inserto
	hora_salida		TIME 	NOT NULL,

	PRIMARY KEY(id_turno)
);


CREATE TABLE jornada_emp(
	empleado_id 	INTEGER	NOT NULL,
	fecha_inicio	DATE    NOT NULL,
	fecha_termino   DATE,
	turno_id        INTEGER NOT NULL, 

	PRIMARY KEY (empleado_id, fecha_inicio),
	FOREIGN KEY (empleado_id) REFERENCES empleado(id_empleado),
	FOREIGN KEY (turno_id)	  REFERENCES turno(id_turno)
);


CREATE TABLE curso(
	id_curso			SERIAL   NOT NULL,
	descripcion    		TEXT     NOT NULL,
	duracion_horas		INTEGER  NOT NULL,
	empleado_id			INTEGER	 NOT NULL,

	PRIMARY KEY (id_curso),
	FOREIGN KEY (empleado_id) REFERENCES empleado(id_empleado)
);

CREATE TABLE capacitacion(
	curso_id		SERIAL   NOT NULL,
	empleado_id		INTEGER	 NOT NULL,
	fecha           DATE     NOT NULL,

	PRIMARY KEY(curso_id, empleado_id),
	FOREIGN KEY(curso_id) REFERENCES curso (id_curso),
	FOREIGN KEY(empleado_id) REFERENCES empleado(id_empleado)
);


CREATE TABLE evaluacion(
	empleado_id		 INTEGER 		NOT NULL,	
	fecha 			 DATE    		NOT NULL,    
	rating			 VARCHAR(30)	NOT NULL,
	observaciones    TEXT

	PRIMARY KEY(empleado_id, fecha),
	FOREIGN KEY(empleado_id) REFERENCES empleado (id_empleado),
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
	empleado_id			INTEGER 	NOT NULL,
	fecha_inicio		DATE 		NOT NULL,
	fecha_termino		DATE 		NOT NULL,
	tipo				VARCHAR(20)	NOT NULL,
	cargo_id		    INTEGER		NOT NULL,

	PRIMARY KEY(empleado_id, fecha_inicio),
	FOREIGN KEY(empleado_id) REFERENCES empleado (id_empleado),
	FOREIGN KEY(cargo_id) REFERENCES cargo(id_cargo)
);

CREATE TABLE salario(
	contrato_id		
	fecha_inicio
	salario_base
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
	empleado_id			INTEGER 	NOT NULL,
	fecha_hora_in		TIMESTAMP	NOT NULL,
	fecha_hora_out		TIMESTAMP   NOT NULL,
	tipo				VARCHAR(20) NOT NULL,
	oficina_id          INTEGER		NOT NULL,

	PRIMARY KEY(empleado_id, fecha_hora_in),
	FOREIGN KEY(empleado_id) REFERENCES empleado(id_empleado),
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

CREATE TABLE postulacion(
	candidato_id	  	SERIAL NOT NULL,
	vacante_id			
	rating
	status			
);