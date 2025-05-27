Descripcion general : 1. La tabla auditoria_tarjeta permite registrar cada vez que una tarjeta cambia de estado, guardando información clave como el identificador de la tarjeta (tarjeta_id), el estado anterior, el nuevo estado y la fecha del cambio. Esta funcionalidad sirve como un historial de todos los eventos importantes relacionados con el estado de las tarjetas, lo que permite realizar auditorías y detectar posibles irregularidades, como cambios frecuentes o no autorizados. Cada vez que el sistema o un usuario autorizado modifica el estado de una tarjeta (por ejemplo, de "activa" a "bloqueada"), se debe insertar manualmente un nuevo registro en esta tabla con los datos correspondientes. Posteriormente, se pueden ejecutar consultas como la cantidad de cambios de estado por mes en el último año o identificar las cinco tarjetas con más modificaciones, lo cual es útil para análisis de comportamiento y seguridad del sistema.
2. La funcionalidad de la tabla promociones permite registrar distintos tipos de beneficios que pueden aplicarse al momento de realizar una recarga, como descuentos, bonus o cualquier otro tipo especial de incentivo. Cada promoción cuenta con un nombre, una descripción detallada, un tipo clasificado como “DESCUENTO”, “BONUS” u “OTRO”, un valor asociado y un período de validez definido por una fecha de inicio y una de finalización. Por ejemplo, se pueden registrar promociones como un descuento para usuarios frecuentes, un bono de bienvenida para nuevas recargas o una cortesía otorgada durante una fecha especial. Esto permite que, al hacer una recarga, el sistema asocie la promoción correspondiente, y más adelante se puedan consultar todas las recargas con la promoción aplicada, calcular el monto total recargado por tipo de promoción en los últimos meses, o identificar aquellas cuyo nombre incluya palabras clave como “bonus”. Esta estructura facilita tanto la experiencia del usuario como el análisis estratégico por parte del área comercial.
 
3. La funcionalidad de las tablas dispositivos y validaciones está orientada a registrar qué dispositivo fue utilizado para validar cada viaje, lo cual es clave para asegurar la trazabilidad del sistema y generar estadísticas precisas. Cada vez que un usuario valida su viaje, se almacena un registro en la tabla validaciones, vinculando el viaje con un dispositivo específico y la fecha en que ocurrió. Por su parte, la tabla dispositivos guarda los detalles de cada equipo, incluyendo su tipo (como torniquete, validador móvil o lector QR) y la fecha en que fue instalado. Gracias a este modelo, se pueden realizar consultas importantes como detectar viajes que no tienen validación registrada, identificar cuántas validaciones fueron hechas por dispositivos móviles en un mes determinado , o saber cuál es el dispositivo que más validaciones ha realizado. Esta estructura mejora la supervisión operativa y facilita la toma de decisiones técnicas o comerciales basadas en datos reales.
 4.La tabla medios_pago tiene la función de almacenar y organizar los distintos métodos o formas de pago que los usuarios pueden utilizar para realizar recargas o transacciones dentro del sistema. Esta tabla actúa como un catálogo maestro que permite identificar y clasificar cada medio de pago mediante un identificador único y un nombre descriptivo.

Instrucciones: 
1. Modificaciones o creación de estructuras base (si es necesario)
Antes de crear nuevas tablas, asegúrate de que existen las tablas referenciadas como viajes, tarjetas, recargas, etc., ya que algunas tablas usan claves foráneas. Si ya existen, continúa; de lo contrario, crea primero esas tablas mínimas.

2. Creación de tablas
Ejecuta los scripts de creación de tablas en este orden para garantizar que las claves foráneas funcionen correctamente:
-Tabla dispositivos
-Tabla validaciones (hace referencia a dispositivos y viajes)
-Tabla promociones
-Tabla medios_pago (almacena los métodos de pago)
-Tabla auditoria_tarjeta (hace referencia a tarjetas)

3. Carga de datos
Una vez creadas las tablas, inserta los registros de prueba o iniciales en el siguiente orden:
-Inserta dispositivos en la tabla dispositivos
-Inserta registros de validación en la tabla validaciones
-Inserta promociones en la tabla promociones
-Inserta medios de pago en la tabla medios_pago
-Inserta cambios de estado en auditoria_tarjeta si tienes datos preparados
4. Consultas
Con las tablas y datos cargados, ya puedes ejecutar las consultas requeridas para análisis, auditoría o gestión, combinando la información de las tablas según sea necesario.

Diagrama : tablas Tarjeta- Auditoria- Recargas-Promociones
erDiagram
    RECARGAS ||--o{ TARJETAS : "tiene"
    RECARGAS ||--o| PROMOCIONES : "aplica"
    TARJETAS ||--o{ AUDITORIA_TARJETA : "registra"
 
    RECARGAS {
        integer recarga_id PK
        date fecha
        double_precision monto
        integer punto_recarga_id
        integer tarjeta_id FK
        integer promociones_id FK
        integer medio_id
    }
 
    PROMOCIONES {
        integer promocionei_id PK
        varchar(100) nombre "NOT NULL"
        list descripcion
        varchar(50) tipo "CHECK (tipo IN ('DESCUENTO', 'BONO', 'OTRO'))"
        decimal valor "NOT NULL"
        date fecha_inicio "NOT NULL"
        date fecha_fin "NOT NULL"
    }
 
    TARJETAS {
        integer tarjeta_id PK
        integer usuario_id
        date fecha_adquisicion
        character_varying estado
        character_varying fecha_caducidad
        character_varying tipo
        date fecha_actualizacion
    }
 
    AUDITORIA_TARJETA {
        integer auditoria_id PK
        integer tarjeta_id FK
        varchar(50) estado_anterior
        varchar(50) estado_nuevo
        date fecha_cambio
    }
Diagrama:dispositivos-validaciones-viajes
erDiagram
    VIAJES ||--o{ VALIDACIONES : "genera"
    DISPOSITIVOS ||--o{ VALIDACIONES : "registra_en"
 
    VIAJES {
        int viaje_id PK
        int estacion_abordaje_id FK
        date fecha
        int tarifa_id FK
        int tarjeta_id FK
    }
 
    DISPOSITIVOS {
        int dispositivo_id PK
        varchar(50) tipo "torniquete, móvil, etc."
        date fecha_instalacion
        int codigo_identificacion
    }
 
    VALIDACIONES {
        int validacion_id PK
        int viaje_id FK
        int dispositivo_id FK
        date fecha
    }
    
Resumen: Resumen:

promociones
Registra las promociones disponibles (descuentos, bonos, otros) que pueden aplicarse a recargas. Incluye nombre, tipo, valor y vigencia.

auditoria_tarjeta
Lleva un historial de los cambios de estado de cada tarjeta (activa, bloqueada, etc.) para fines de auditoría y control.

dispositivos
Almacena los diferentes dispositivos de validación utilizados (torniquetes, validadores móviles, lectores QR), incluyendo su tipo y fecha de instalación.

validaciones
Registra cada validación de viaje, asociando un viaje con un dispositivo específico y una fecha, permitiendo trazabilidad de los viajes.

medios_pago
Contiene los distintos métodos de pago disponibles para realizar recargas (efectivo, tarjeta crédito, PSE, billeteras digitales, etc.), facilitando el análisis de preferencias y optimización de canales de recarga.

(Modificación de recargas)
Se agregó una columna promociones_id para relacionar cada recarga con una promoción aplicada, fortaleciendo el análisis comercial y la experiencia del usuario. También se agregó medio_id para registrar el medio de pago usado en cada recarga, permitiendo segmentar y estudiar el comportamiento de pago de los usuarios.

Descripcion tipo de dato: 
-promociones
Se insertan datos como nombres de promociones, tipos de beneficio (bono, descuento), valores numéricos y fechas de inicio y fin de la vigencia.
-auditoria_tarjeta
Los registros incluyen el identificador de la tarjeta, el estado al que cambia (activo, bloqueado, cancelado), y la fecha en la que se realiza dicho cambio, para llevar el historial de uso y control.
-dispositivos
Se agregan diferentes dispositivos utilizados en el sistema de validación, como torniquetes, validadores móviles y lectores QR, con su tipo y la fecha en que fueron instalados.
-validaciones
Los datos insertados relacionan un viaje específico con el dispositivo que lo validó y la fecha exacta de esa validación, permitiendo rastrear cómo y cuándo se usaron los medios de transporte.
-medios_pago
Se ingresan los tipos de medios aceptados para realizar recargas, tales como efectivo, tarjeta de crédito, PSE, Nequi, Daviplata, etc., identificados por nombre.
-recargas (modificada)
Se incluyen identificadores de promociones aplicadas y del medio de pago utilizado, además del resto de la información de cada recarga (ya existente), lo que permite vincular promociones y formas de pago a cada transacción.

Listado de consultas: 
-Viajes sin registro de validación
Consulta que identifica los viajes que no tienen una entrada en la tabla validaciones, permitiendo detectar posibles fallos en el sistema de validación.

-Validaciones realizadas por dispositivos móviles por fecha
Filtra las validaciones hechas por dispositivos cuyo tipo sea “Validador móvil” y cuya fecha esté dentro de abril de 2025, útil para análisis operativos.

-Dispositivo con mayor cantidad de validaciones
Cuenta cuántas validaciones ha realizado cada dispositivo y muestra el de mayor uso, ayudando en decisiones de mantenimiento o inversión.

-Recargas con promoción aplicada
Muestra todas las recargas que están asociadas a una promoción, permitiendo evaluar el impacto de las promociones en el sistema.

-Historial de cambios de estado de una tarjeta específica
Consulta que muestra todos los cambios registrados para una tarjeta dada, útil para auditoría o atención a usuarios.

-Consulta de recargas realizadas con un medio de pago específico en un mes determinado
Permite filtrar por mes y medio de pago, útil para análisis contables o preferencias de usuarios.

-Recargas sin promoción aplicada
Identifica las recargas que no están asociadas a ninguna promoción, lo que ayuda a estudiar el alcance de las campañas promocionales.

-Resumen de validaciones por tipo de dispositivo (JOIN)
Relaciona validaciones con dispositivos para agrupar cuántas veces se usó cada tipo de dispositivo.

-Consulta JOIN de recargas, promociones y medios de pago
Muestra detalles combinados de cada recarga junto a su promoción (si la hay) y medio de pago, útil para análisis comerciales.

-Recargas totales por medio de pago (JOIN)
Agrupa las recargas por tipo de medio de pago, permitiendo entender qué métodos son más utilizados.


