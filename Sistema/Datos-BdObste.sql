select * from pacientes

--*************************************************************

INSERT INTO pacientes 
(nombre_completo, dni, fecha_nacimiento, telefono, direccion)
VALUES
('Ana Mendoza Torres', '1234567890', '1990-05-15', '987654321', 'Av. Lima 123'),
('Sofía Huamán Rojas', '2345678901', '1985-08-22', '987123456', 'Jr. Ayacucho 456'),
('Lucía Quispe Flores', '3456789012', '1995-03-10', '987456123', 'Calle Tacna 789'),
('María López García', '4567890123', '1988-11-28', '987789456', 'Av. Arequipa 1011'),
('Carmen Díaz Vargas', '5678901234', '1992-07-17', '987321654', 'Jr. Cusco 1213');

INSERT INTO pacientes 
(nombre_completo, dni, fecha_nacimiento, telefono, direccion)
VALUES
('Rosa Camacho Velásquez', '6789012345', '1987-04-12', '987654987', 'Av. Brasil 2345'),
('Elena Mendoza Castro', '7890123456', '1993-09-25', '987123789', 'Jr. Junín 567'),
('Patricia Salazar López', '8901234567', '1984-12-30', '987456987', 'Calle Moquegua 890'),
('Gabriela Torres Ruiz', '9012345678', '1991-07-18', '987789123', 'Av. Tacna 1112'),
('Daniela Vargas Paredes', '0123456789', '1989-02-14', '987321987', 'Jr. Ica 1314'),

('Juana Ríos Mendoza', '1122334455', '1994-05-20', '987654111', 'Av. La Marina 1516'),
('Silvia Quiroz Díaz', '2233445566', '1986-08-15', '987123222', 'Jr. Huánuco 1718'),
('Adriana Flores Gutierrez', '3344556677', '1990-11-08', '987456333', 'Calle Ancash 1920'),
('Beatriz Medina Soto', '4455667788', '1983-03-22', '987789444', 'Av. Grau 2122'),
('Natalia Herrera Chávez', '5566778899', '1995-06-05', '987321555', 'Jr. Lambayeque 2324'),

('Mónica Castro Rojas', '6677889900', '1988-10-17', '987654666', 'Av. Alfonso Ugarte 2526'),
('Verónica Ortiz Silva', '7788990011', '1992-01-28', '987123777', 'Jr. Apurímac 2728'),
('Claudia Peña Velarde', '8899001122', '1985-04-03', '987456888', 'Calle Huancavelica 2930'),
('Susana Cordero Montes', '9900112233', '1996-07-11', '987789999', 'Av. Salaverry 3132'),
('Paola Navarro Jiménez', '0011223344', '1982-09-24', '987321000', 'Jr. Loreto 3334'),

('Diana Romero Ponce', '1029384756', '1997-12-07', '987654222', 'Av. Petit Thouars 3536'),
('Karen Salinas Bravo', '2938475601', '1981-02-19', '987123333', 'Jr. Amazonas 3738'),
('Liliana Cabrera Fuentes', '3847560129', '1998-05-02', '987456444', 'Calle Ucayali 3940'),
('Gloria Espinoza Ríos', '4756012938', '1980-08-14', '987789555', 'Av. Colonial 4142'),
('Teresa León Valdivia', '5601293847', '1999-10-27', '987321666', 'Jr. Madre de Dios 4344');

--***************************************************************************************

-- Citas para pacientes 7-16
INSERT INTO citas (id_obstetra, id_paciente, fecha_cita, id_programa, estado_cita, observaciones)
VALUES
(2, 7, '2023-03-10 09:00:00', 1, 2, 'Control anual de Papanicolao - Resultados normales'), -- Ana Mendoza Torres
(3, 8, '2023-03-15 10:30:00', 2, 2, 'Aplicación de IVA - Paciente asintomática'), -- Sofia Huamán Rojas
(2, 9, '2023-03-20 14:00:00', 3, 1, 'Tamizaje de VPH programado'), -- Lucia Quispe Flores
(3, 10, '2023-04-05 09:30:00', 4, 2, 'Consejería en planificación familiar'), -- Maria López García
(2, 11, '2023-04-10 16:00:00', 5, 2, 'Examen de mamas - Hallazgos normales'), -- Carmen Díaz Vargas
(3, 12, '2023-05-05 10:00:00', 1, 1, 'Primer control ginecológico'), -- Rosa Camacho Velásquez
(2, 13, '2023-05-10 11:30:00', 2, 2, 'IVA realizado - Muestra tomada'), -- Elena Mendoza Castro
(3, 14, '2023-06-07 08:30:00', 3, 0, 'Cancelado por paciente - Reagendar'), -- Patricia Salazar López
(2, 15, '2023-06-12 15:00:00', 4, 2, 'Consejería en climaterio'), -- Gabriela Torres Ruiz
(3, 16, '2023-07-03 09:00:00', 5, 1, 'Control mamario de rutina'); -- Daniela Vargas Paredes

-- Citas para pacientes 17-26
INSERT INTO citas (id_obstetra, id_paciente, fecha_cita, id_programa, estado_cita, observaciones)
VALUES
(2, 17, '2023-07-18 13:30:00', 1, 2, 'Papanicolao - Muestra enviada'), -- Juana Rios Mendoza
(3, 18, '2023-08-02 10:15:00', 2, 1, 'Control post-IVA'), -- Silvia Quiroz Díaz
(2, 19, '2023-08-09 16:00:00', 3, 2, 'VPH - Primera dosis aplicada'), -- Adriana Flores Gutierrez
(3, 20, '2023-09-01 09:00:00', 4, 2, 'Consejería posparto completada'), -- Beatriz Medina Soto
(2, 21, '2023-09-15 11:00:00', 5, 1, 'Seguimiento de nódulo benigno'), -- Natalia Herrera Chávez
(3, 22, '2023-10-03 08:30:00', 1, 2, 'Papanicolao anual - Sin anomalías'), -- Mónica Castro Rojas
(2, 23, '2023-10-17 14:00:00', 2, 0, 'Paciente no se presentó'), -- Verónica Ortiz Silva
(3, 24, '2023-11-07 10:30:00', 3, 1, 'Tamizaje VPH programado'), -- Claudia Peña Velarde
(2, 25, '2023-11-21 15:00:00', 4, 2, 'Consejería en lactancia materna'), -- Susana Cordero Montes
(3, 26, '2023-12-05 09:30:00', 5, 2, 'Examen de mamas - Quiste simple'); -- Paola Navarro Jiménez

-- Citas para pacientes 27-31
INSERT INTO citas (id_obstetra, id_paciente, fecha_cita, id_programa, estado_cita, observaciones)
VALUES
(2, 27, '2024-01-10 09:00:00', 1, 1, 'Control ginecológico anual'), -- Diana Romero Ponce
(3, 28, '2024-01-15 10:30:00', 2, 1, 'Aplicación de IVA programada'), -- Karen Salinas Bravo
(2, 29, '2024-02-01 14:00:00', 3, 1, 'Primera dosis de VPH'), -- Liliana Cabrera Fuentes
(3, 30, '2024-02-14 11:15:00', 4, 1, 'Consejería en menopausia'), -- Gloria Espinoza Rios
(2, 31, '2024-03-05 08:30:00', 5, 1, 'Examen de mamas preventivo'); -- Teresa León Valdivia