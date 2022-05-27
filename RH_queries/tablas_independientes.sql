----------- DEPARTAMENTOS
INSERT INTO departamento VALUES (1, 'Recursos Humano', 'Encargado de llevar el control de toda la información de los empleados en la empresa, desde sus contratos, salarios, beneficios o prestaciones que se lesotorgan a los empleados.');
INSERT INTO departamento VALUES (2, 'Transporte de Personal','Encargada de llevar el control y registro de las rutas planeadas, autobuses con los que se cuentan y choferes disponibles para el transporte de personal, así como los viajes que se realizan.');
INSERT INTO departamento VALUES (3, 'Ventas','Está cargo de la identificaciónde cada una de las ventas  de  la  empresa  yde  bienes raíces,  llevara  toda  la documentaciónde identificaciónde lavivienda y sus mantenimientos que se le soliciten y de la misma forma identificara a los vendedores involucrados asícomo a los clientes de tal manera que proporcionara aclaraciones si se solicitan en documentacióny generara los reportes que sean necesarios para esclarecer dudas dentro de la empresa.' );
INSERT INTO departamento VALUES (4, 'Finanzas','Encargado de la movilización y administración de los recursos financieros del banco, correspondientes tanto al activo como el pasivo de la organización, incluyendofondos provenientes del endeudamiento y de otra índole, la administración de la liquides de la institución, la contabilidad y los registros financieros de sus operaciones, el manejo de las relaciones del banco con los mercados y los agentes financieros.');
INSERT INTO departamento VALUES (5, 'Importaciones', 'El encargado de contar con la mercancía en tiempo y forma de acuerdo con las necesidades de la empresa en territorio nacional y internacional');
INSERT INTO departamento VALUES (6, 'Control de Inventarios','Garantizar el abasto suficiente de los artículos y productos recurrentes,');
INSERT INTO departamento VALUES (7, 'Manufactura','Función principal la transformación de insumos o recursos (energía, materia prima, mano de obra, capital, información) en productos finales (bienes o servicios)');
INSERT INTO departamento VALUES (8, 'Marketing','Es el responsable de satisfacer las necesidades del cliente, lo que tiene un impacto directo en la obtención de ganancias. ');


----------- CARGO
--- RH
INSERT INTO cargo VALUES (1,'Jefe de Departamento','Encargado de gestionar y coordinar a los equipos y personas de RRHH. Analizar y gestionar el cuadro de mando de Recursos Humanos.',1);
INSERT INTO cargo VALUES (2,'Capturista de Datos','Encargados de llevar a cabo registros de las actividades realizadas por los empleados y los distintos departamentos de una empresa u organización. Además digitalizan la información que sea requerida.',1);
INSERT INTO cargo VALUES (3,'Responsable de administracion de Presonal','Supervisar todos los procesos administrativos y de comunicación del personal, además de implementar las políticas de retribución e incentivos y administrar el pago de obligaciones y previsiones tributarias.',1);
INSERT INTO cargo VALUES (4,'Técnico de selección de personal','Encargado de detectar las necesidades del cliente interno, publicar las ofertas de empleo, gestionar estas ofertas y realizar una búsqueda directa. También deberá hacer las entrevistas, gestión de la incorporación de nuevos candidatos y medidas para retener el talento.',1);
INSERT INTO cargo VALUES (5,'Responsable de Formación y Desarrollo','El rol del responsable en formación y desarrollo consiste en detectar las necesidades de formación para cada departamento o área de la empresa y diseñar un plan de formación para empleados para satisfacer esas necesidades.',1);
INSERT INTO cargo VALUES (6,'Técnico de Formación y Desarrollo', 'Encargado de aplicar la formación de los empleados mediante capacitaciones, evaluaciones, cursos , etc.');


--- Transporte
INSERT INTO cargo VALUES (7,'Jefe de Departamento TP','Gestiona las rutas, horarios',2) --- Opcional
INSERT INTO cargo VALUES (8,'Chofer','Encargado de ir al mando del vehículo en el que los empleados se transporten.',2);


--- Ventas

--- Finanzas

--- Importaciones
INSERT INTO cargo VALUES (n , 'Proveedor')

--- Control de Inventarios


--- Manufactura

--- Marketing
INSERT INTO cargo VALUES (n, 'Jefe de Departamento MKT','Gestiona el departamento de Marketing',8); -- Opcional
INSERT INTO cargo VALUES (n, 'Jefe de Campaña','Encargado de planear Campañas de marketing',8);
INSERT INTO cargo VALUES (n, 'Titular de Promociones','Encargado de planear promociones en conjunto con analista y jefe de campaña',8);
INSERT INTO cargo VALUES (n, 'Analista','Encargado de analizar informacion del mercado para trabajar en conjunto con el titular de promociones y el jefe de campañas para la planeacion de campañas de marketing',8);





----------- PRESTACIONES
--- LEY
--- Checar si cambiar "duracion" de DATE a VARCHAR
INSERT INTO prestacion VALUES (1, 'vacaciones','ley','disfrutar en forma continua 6 días de vacaciones, por lo menos.', '2021/03/18', 650.30 )
INSERT INTO prestacion VALUES (2, 'aguinaldo', 'ley', 'un aguinaldo anual que deberá pagarse antes del día 20 de diciembre, equivalente a quince días de salario, por lo menos.','2021/03/18', )
INSERT INTO prestacion VALUES (id_prestacion, nombre, tipo , descripcion, duracion, monto)


----------- TURNO
--- Esto solo en caso de que el servidor este configurado en otra region
SHOW TIMEZONE
SET TIMEZONE = 'America/Mexico_City'


INSERT INTO turno VALUES (1, '7:00:25-07','14:00:25-07');   -- Matutino     8 horas
INSERT INTO turno VALUES (2,'14:00:25-07','21:00:25-07');   -- Vespertino   7 horas
INSERT INTO turno VALUES (3,'16:30:25-07','23:30:25-07');  -- Mixto        7 horas y media
