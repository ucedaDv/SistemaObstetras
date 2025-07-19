CREATE DATABASE obstetriciaDB
USE obstetriciaDB

CREATE TABLE usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre_completo NVARCHAR(100) NOT NULL,
    usuario NVARCHAR(50) NOT NULL UNIQUE,
    contrasena NVARCHAR(256) NOT NULL,
    pregunta_seguridad NVARCHAR(200),
    respuesta_seguridad NVARCHAR(200),
    intentos_restantes INT DEFAULT 5,
    estado INT DEFAULT 1,
    rol NVARCHAR(20) NOT NULL,  -- ADMIN o OBSTETRA
    fecha_bloqueo DATETIME
);


INSERT INTO usuarios 
(nombre_completo, usuario, contrasena, pregunta_seguridad, respuesta_seguridad, intentos_restantes, estado, rol, fecha_bloqueo)
VALUES
('Administrador General', 'admin', '6c2f8fbb39131df981b1e743ee28a7358b8b9cf8d460e6fcdd98d2b46a2ef7f0', 
'¿Color favorito?', 'Azul', 5, 1, 'ADMIN', NULL);

UPDATE usuarios SET intentos_restantes = 5, estado = 1, fecha_bloqueo = NULL WHERE usuario = 'admin';
UPDATE usuarios SET rol = 'ADMIN' WHERE usuario = 'admin';

select * from usuarios

-- agrego dni para las obstetras como usuario general
ALTER TABLE usuarios
ADD dni NVARCHAR(15) NULL;

CREATE UNIQUE NONCLUSTERED INDEX UQ_Usuarios_DNI_NotNull
ON usuarios (dni)
WHERE dni IS NOT NULL;

-- tabla pacientes

CREATE TABLE pacientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre_completo VARCHAR(100),
    dni VARCHAR(10) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(150),
    estado INT DEFAULT 1  -- 1: activo, 0: inactivo (eliminado lógicamente)
);

select * from pacientes

-- CITAS

-- Opcional: Si quieres tener los programas preventivos en una tabla separada (mejor práctica a largo plazo)


-- Entonces, la tabla citas cambiaría a:
CREATE TABLE citas (
    id_cita INT PRIMARY KEY IDENTITY(1,1),
    id_obstetra INT NOT NULL, -- Quién agenda la cita (FK a usuarios)
    id_paciente INT NOT NULL, -- Para quién es la cita (FK a pacientes)
    fecha_cita DATETIME NOT NULL, -- Fecha y hora de la cita
    id_programa INT NOT NULL, -- FK a programas_preventivos
    estado_cita INT NOT NULL DEFAULT 1, -- 1: PENDIENTE, 2: ATENDIDO, 0: CANCELADO
    observaciones TEXT, -- Campo opcional para notas
    fecha_registro DATETIME DEFAULT GETDATE(), -- Usar GETDATE() para SQL Server para la fecha y hora actual
    CONSTRAINT fk_obstetra FOREIGN KEY (id_obstetra) REFERENCES usuarios(id),
    CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id), -- Asumiendo que tu tabla pacientes tiene id_paciente
    CONSTRAINT fk_programa FOREIGN KEY (id_programa) REFERENCES programas_preventivos(id_programa)
);


CREATE TABLE programas_preventivos (
    id_programa INT PRIMARY KEY IDENTITY(1,1),
    nombre_programa VARCHAR(100) UNIQUE NOT NULL
);

-- Y llenar la tabla programas_preventivos con tus 5 programas:
INSERT INTO programas_preventivos (nombre_programa) VALUES
('Papanicolao'),
('IVA'),
('VPH'),
('Consejeria'),
('Examen de mamas');

