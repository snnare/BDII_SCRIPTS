CREATE TABLE PAGO_RENTA(
id_renta            SERIAL          NOT NULL,
fecha_inicio        DATE            NOT NULL,
fecha_termino       DATE            NOT NULL,
costo               NUMERIC(6,2)    NOT NULL,
PRIMARY KEY (id_renta, fecha_inicio)    
);


CREATE TABLE BODEGA(
bodega_id       SERIAL        PRIMARY KEY,
tamanio         VARCHAR(20)   NOT NULL,
capacidad       VARCHAR(20)   NOT NULL,
direccion_id    SERIAL        NOT NULL)
FOREIGN KEY (direccion_id) REFERENCES direccion(id_direccion);


CREATE TABLE RENTA(
id_renta            SERIAL PRIMARY KEY      NOT NULL,
bodega_id           SERIAL                  NOT NULL,
fecha_contratacion  DATE                    NOT NULL,
fecha_termino       DATE                    NOT NULL,
provedor            VARCHAR(50)             NOT NULL,
deposito            NUMERIC(6,2)            NOT NULL);

ALTER TABLE RENTA
add constraint FK_RENTA_bodega_id
foreign key (bodega_id)
references BODEGA(bodega_id);


CREATE TABLE MOV_SALIDA(
id_mov_salida       SERIAL PRIMARY KEY  NOT NULL,
fecha_envio         DATE                NOT NULL,
fecha_recepcion     DATE                NOT NULL,
id_manufactura      INT                 NOT NULL);

-- NOTA IMPORTANTE: para hacer este alter table necesitamos la tabla de manufactura creada antes
-- ya que hcaemos uso de la llave foranea 

ALTER TABLE MOV_SALIDA
add constraint FK_MOV_SALIDA_id_manufactura
foreign key (id_manufactura)
references manufactura(id_manufactura);

CREATE TABLE INVENTARIO(
producto_pedido_id  INT     NOT NULL,
bodega_id           INT     NOT NULL,
fecha_entrada       DATE    NOT NULL,
fecha_salida        DATE    NOT NULL,
id_mov_salida       SERIAL  NOT NULL,
    PRIMARY KEY(producto_pedido_id),
    FOREIGN KEY(producto_pedido_id) REFERENCES producto_pedido(id_producto_pedido)

);

ALTER TABLE INVENTARIO
add constraint FK_INVENTARIO_id_mov_salida
foreign key (id_mov_salida)
references MOV_SALIDA(id_mov_salida);
