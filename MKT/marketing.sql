CREATE TABLE promocion (
id_promocion NUMERIC constraint pk_promocion PRIMARY KEY,
nombre VARCHAR(50),
descripcion VARCHAR(70),
tipo VARCHAR(30));


CREATE TABLE promocion_man (
promocion_man_id NUMERIC constraint pk_promocion_man PRIMARY KEY,
manufactura_id INTEGER constraint fk_manufactura_promocion_man
                           references manufactura(id_manufactura),
id_promocion NUMERIC constraint fk_promocion_promocion_man
                           references promocion(id_promocion),                         
fecha_inicio DATE,
fecha_termino DATE,
descuento NUMERIC);


CREATE TABLE campania (
id_campania NUMERIC constraint pk_campania PRIMARY KEY,
fecha_inicio DATE,
fecha_termino DATE,
audiencia VARCHAR(30),
region VARCHAR(30),
promocion_man_id NUMERIC constraint fk_campania_promocion_man
                                    references promocion_man(promocion_man_id));


CREATE TABLE anuncio (
id_anuncio NUMERIC constraint pk_anuncio PRIMARY KEY,
id_campania NUMERIC constraint fk_anuncio_campania
                               references campania(id_campania),
contacto VARCHAR(50),
proveedor VARCHAR(50),
costo NUMERIC(20,2),
promocion_man_id NUMERIC constraint fk_anuncio_promocion_man
                         references promocion_man(promocion_man_id));


CREATE TABLE ad_fisico (
id_anuncio NUMERIC constraint fk_ad_fisico_anuncio 
                   references anuncio(id_anuncio),
fecha_inicio DATE,
fecha_termino DATE,
ubicacion VARCHAR(50))
INHERITS(anuncio);



CREATE TABLE ad_web (
id_anuncio NUMERIC constraint fk_ad_fisico_anuncio 
                   references anuncio(id_anuncio),
fecha_inicio DATE,
fecha_termini DATE,
tipo VARCHAR(50),
url VARCHAR(100))
INHERITS(anuncio);


CREATE TABLE ad_broadcast (
id_anuncio NUMERIC constraint fk_ad_fisico_anuncio 
                   references anuncio(id_anuncio),
fecha_hora DATE,
broadcast_channel VARCHAR(30))
INHERITS(anuncio);

