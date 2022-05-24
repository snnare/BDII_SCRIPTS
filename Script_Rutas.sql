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

CREATE TABLE mantenimiento(
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