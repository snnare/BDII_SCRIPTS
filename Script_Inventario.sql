CREATE TABLE PAGO_RENTA(
id_renta INT PRIMARY KEY NOT NULL,
fecha_inicio DATE NOT NULL,
fecha_termino DATE NOT NULL,
costo INT NOT NULL);

CREATE TABLE BODEGA(
bodega_id INT PRIMARY KEY NOT NULL,
tamanio VARCHAR(50) NOT NULL,
capacidad VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL);

CREATE TABLE RENTA(
id_renta INT PRIMARY KEY NOT NULL,
bodega_id INT NOT NULL,
fecha_contratacion DATE NOT NULL,
fecha_termino DATE NOT NULL,
provedor VARCHAR(50) NOT NULL,
deposito INT NOT NULL);

ALTER TABLE RENTA
add constraint FK_RENTA_bodega_id
foreign key (bodega_id)
references BODEGA(bodega_id);

CREATE TABLE MOV_SALIDA(
id_mov_salida INT PRIMARY KEY NOT NULL,
fecha_hora_envio DATE NOT NULL,
fecha_hora_recepcion DATE NOT NULL,
manufactura_id INT NOT NULL);

-- NOTA IMPORTANTE: para hacer este alter table necesitamos la tabla de manufactura creada antes
-- ya que hcaemos uso de la llave foranea  
ALTER TABLE MOV_SALIDA
add constraint FK_MOV_SALIDA_manufactura_id
foreign key (manufactura_id)
references MANUFACTURA(manufactura_id);

CREATE TABLE INVENTARIO(
producto_pedido_id INT NOT NULL,
bodega_id INT NOT NULL,
fecha_hora_entrada DATE NOT NULL,
fecha_hora_salida DATE NOT NULL,
id_mov_salida INT NOT NULL);

ALTER TABLE INVENTARIO
add constraint FK_INVENTARIO_id_mov_salida
foreign key (id_mov_salida)
references MOV_SALIDA(id_mov_salida);