# DETALLE: SistemaObstetras

#🎯 Objetivo General
Desarrollar un sistema de escritorio en Java para la gestión de pacientes, obstetras y programas preventivos del MINSA, con funcionalidades avanzadas de estadísticas y gráficos para el seguimiento de citas médicas y metas por obstetra.

#USUARIOS PARA INGRESAR:
USUARIO - CONTRASEÑA:
admin - admin123
obstetra - obstetra123

#🔐 Ingreso al Sistema (Login)
- Inicio de sesión para usuarios registrados (administradores y obstetras).
- Validación de DNI y contraseña.
- Bloqueo automático tras varios intentos fallidos.
- Desbloqueo con código enviado (simulado).
- Recuperación de contraseña (simulada).
- Acceso restringido por rol:

ADMIN: Accede a todas las funcionalidades.

OBSTETRA: Solo puede visualizar sus citas.

#🧩 Funcionalidades Generales
👤 Gestión de Usuarios
- Registro, modificación y eliminación lógica de usuarios.
- Solo usuarios con rol ADMIN pueden gestionar usuarios.

#🩺 Gestión de Obstetras
- Registro y listado de obstetras con opción de modificar/eliminar.
- Filtro de obstetras por DNI y nombre.

#🧍‍♀️ Gestión de Pacientes
- Registro de pacientes con datos básicos.
- Listado con edición y eliminación lógica.
- Búsqueda por DNI y nombre.

#📅 Gestión de Citas Médicas
- Registro de citas vinculadas a:
- Paciente.
- Obstetra.
-Programa preventivo.
- Estados de cita: Pendiente, Atendida, Cancelada.
- Modificación de citas.
- Filtro por fecha, estado, paciente y obstetra.

#📈 Módulo de Estadísticas (Solo Admin)
- Estadísticas por programa preventivo:
- Total de citas.
- Total atendidas.
- Porcentaje de atención.
- Estadísticas por obstetra:
- Mismo formato, filtrando por DNI del obstetra.

Filtros avanzados:
- Por rango de fechas.
- Por uno o varios programas.
- Con o sin obstetra especificado.
Visualización con:
- Gráfico de barras (JFreeChart).
- Tabla de datos numéricos (JTable).

#🛠️ Tecnologías y Herramientas Utilizadas
🔧 Lenguaje y Entorno
- Java (JDK 24)
- Swing para interfaces gráficas.
- JDBC para conexión a base de datos.

#🗃️ Base de Datos
- SQL Server

# Tablas principales:

/ usuarios(dni, nombre, contraseña, rol, estado)

/ pacientes(...)

/ obstetras(...)

/ citas(id, paciente_dni, dni_obstetra, programa, estado, fecha)

/ programas_preventivos(nombre)

#📦 Librerías Externas
-> JFreeChart: Generación de gráficos de barras.
->JCalendar (toedter.calendar.JDateChooser): Selección de fechas.
->Apache Commons Lang/StringUtils (opcional): Validaciones de texto.

#📌 Características Técnicas Clave
- Uso de Map<String, Object> para manejar resultados estadísticos flexibles.
- Eliminación lógica: cambio de estado en lugar de borrado físico.
- Filtro avanzado de datos con múltiples criterios.
- Interfaces amigables y organizadas en pestañas/menús.

#✅ Ventajas del Sistema
- Modularidad: cada componente (usuarios, pacientes, citas, estadísticas) está bien separado.
- Escalabilidad: fácilmente adaptable para incluir más programas o roles.
- Interfaz visual amigable, orientada al uso diario en centros de salud.
- Control total para administradores con reportes visuales e indicadores de rendimiento.
