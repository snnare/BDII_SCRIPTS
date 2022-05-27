----------- DEPARTAMENTOS
INSERT INTO departamento VALUES (1, 'Recursos Humano', 'Encargado de llevar el control de toda la información de los empleados en la empresa, desde sus contratos, salarios, beneficios o prestaciones que se lesotorgan a los empleados.');
INSERT INTO departamento VALUES (2, 'Transporte de Personal','Encargada de llevar el control y registro de las rutas planeadas, autobuses con los que se cuentan y choferes disponibles para el transporte de personal, así como los viajes que se realizan.');
INSERT INTO departamento VALUES (3, 'Ventas','Está cargo de la identificaciónde cada una de las ventas  de  la  empresa  yde  bienes raíces,  llevara  toda  la documentaciónde identificaciónde lavivienda y sus mantenimientos que se le soliciten y de la misma forma identificara a los vendedores involucrados asícomo a los clientes de tal manera que proporcionara aclaraciones si se solicitan en documentacióny generara los reportes que sean necesarios para esclarecer dudas dentro de la empresa.' );
INSERT INTO departamento VALUES (4, 'Finanzas','Encargado de la movilización y administración de los recursos financieros del banco, correspondientes tanto al activo como el pasivo de la organización, incluyendofondos provenientes del endeudamiento y de otra índole, la administración de la liquides de la institución, la contabilidad y los registros financieros de sus operaciones, el manejo de las relaciones del banco con los mercados y los agentes financieros.');
INSERT INTO departamento VALUES (5, 'Importaciones', 'El encargado de contar con la mercancía en tiempo y forma de acuerdo con las necesidades de la empresa en territorio nacional y internacional');
INSERT INTO departamento VALUES (6, 'Control de Inventarios','Garantizar el abasto suficiente de los artículos y productos recurrentes,');
INSERT INTO departamento VALUES (7, 'Manufactura','unción principal la transformación de insumos o recursos (energía, materia prima, mano de obra, capital, información) en productos finales (bienes o servicios)');

----------- PRESTACIONES

--- LEY
--- Checar si cambiar "duracion" de DATE a VARCHAR
INSERT INTO prestacion VALUES (1, 'vacaciones','ley','disfrutar en forma continua 6 días de vacaciones, por lo menos.', '2021/03/18', 650.30 )
INSERT INTO prestacion VALUES (2, 'aguinaldo', 'ley', 'un aguinaldo anual que deberá pagarse antes del día 20 de diciembre, equivalente a quince días de salario, por lo menos.','2021/03/18', )
INSERT INTO prestacion VALUES (id_prestacion, nombre, tipo , descripcion, duracion, monto)