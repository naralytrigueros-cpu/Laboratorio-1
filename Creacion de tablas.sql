-- Crear Database
CREATE DATABASE SistemaVuelosS
GO

USE  SistemaVuelosS;
GO

-- CREACION DE CLAVE MAESTRA
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Administrador';
GO

CREATE CERTIFICATE CertificadoCifrado
WITH SUBJECT = 'Certificado para cifrado de datos sensibles';
GO

-- Create Symmetric Key
CREATE SYMMETRIC KEY ClaveAerolinia
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CertificadoCifrado;
GO

-- TABLA USUARIOS
CREATE TABLE Usuarios (
    Id      INTEGER         NOT NULL PRIMARY KEY,
    NomUsr  VARCHAR(50)     NOT NULL,
    Clave   VARCHAR(50)     NOT NULL
);

-- INSERTS ADMINISTRADOR
INSERT INTO Usuarios VALUES (1, 'Administrador', '12345');
INSERT INTO Usuarios VALUES (2, 'Administrador2', '12345');

-- TABLA AEROLINEA
CREATE TABLE Aerolinia (
    ID          INT PRIMARY KEY,
    Nombre      VARCHAR(100)   NOT NULL,
    Pais        VARCHAR(50)    NOT NULL,
    Codigo      VARCHAR(20)    NOT NULL
);

-- TABLA AVIONES
CREATE TABLE Aviones (
    ID                  INT PRIMARY KEY,
    Modelo              VARCHAR(50) NOT NULL,
    Capacidad_Pasajeros INT NOT NULL,
    Aerolinia_ID        INT,
    CONSTRAINT FK_Aviones_Aerolinia FOREIGN KEY (Aerolinia_ID) REFERENCES Aerolinia (ID)
);

-- TABLA VUELOS
CREATE TABLE Vuelos (
    ID                  INT PRIMARY KEY,
    Origen              VARCHAR(50)     NOT NULL,
    Destino             VARCHAR(100)    NOT NULL,
    Fecha_Hora_Salida   DATETIME        NOT NULL,
    Fecha_Hora_Llegada  DATETIME        NOT NULL,
    Asientos_Disponibles INT            NOT NULL,
    Precio              DECIMAL(10,2),
    Avion_ID            INT,
    CONSTRAINT FK_Vuelos_Aviones FOREIGN KEY (Avion_ID) REFERENCES Aviones (ID)
);


-- TABLA PASAJEROS
CREATE TABLE Pasajeros (
    ID          INT PRIMARY KEY,
    Nombre      VARCHAR(50) NOT NULL,
    Apellido1   VARCHAR(20) NOT NULL,
    Apellido2   VARCHAR(50) NOT NULL,
    Cedula      VARBINARY(500) NOT NULL, 
    Email       VARBINARY(500) NOT NULL, 
    Telefono    VARBINARY(500)           
);


-- TABLA RESERVAS
CREATE TABLE Reservas (
    ID              INT PRIMARY KEY,
    Fecha_Reserva   DATE        NOT NULL,
    Estado          VARCHAR(40) NOT NULL,
    Asiento         VARCHAR(15),
    Pasajero_ID     INT,
    Vuelo_ID        INT,
    CONSTRAINT FK_Reservas_Pasajeros FOREIGN KEY (Pasajero_ID) REFERENCES Pasajeros (ID),
    CONSTRAINT FK_Reservas_Vuelos    FOREIGN KEY (Vuelo_ID) REFERENCES Vuelos (ID)
);

-- TABLA PAGOS
CREATE TABLE Pagos (
    ID          INT PRIMARY KEY,
    Monto       DECIMAL(10,2)   NOT NULL,
    Metodo_Pago VARCHAR(50)     NOT NULL,
    Fecha_Pago  DATE            NOT NULL,
    Estado      VARCHAR(20)     NOT NULL,
    Reserva_ID  INT,
    CONSTRAINT FK_Pagos_Reservas FOREIGN KEY (Reserva_ID) REFERENCES Reservas (ID)
);



-- INSERTS AEROLINEA
INSERT INTO Aerolinia (ID, Nombre, Pais, Codigo) VALUES 
(1, 'Avianca', 'Colombia', 'AV'),
(2, 'Volaris', 'Mexico', 'Y4'),
(3, 'Iberia', 'España', 'IB'),
(4, 'JetBlue', 'Estados Unidos', 'B6'),
(5, 'United Airlines', 'Estados Unidos', 'UA'),
(6, 'Sansa Airlines', 'Costa Rica', 'RZ'),
(7, 'Arajet', 'Republica Dominicana', 'DM'),
(8, 'LATAM', 'Chile', 'LA'),
(9, 'Japan Airlines', 'Japon', 'JL'),
(10, 'Aeromexico', 'Mexico', 'AM'),
(11, 'Qatar Airways', 'Qatar', 'QR'),
(12, 'Singapore Airlines', 'Singapur', 'SQ'),
(13, 'Copa Airlines', 'Panama', 'CM'),
(14, 'Air France', 'Francia', 'AF');

-- INSERTS AVIONES
INSERT INTO Aviones (ID, Modelo, Capacidad_Pasajeros, Aerolinia_ID) VALUES
(1, 'Boeing 737', 180, 1),
(2, 'Boeing 787 Dreamliner', 280, 1),
(3, 'Boeing 747', 340, 3),
(4, 'Antonov An-124', 290, 4),
(5, 'Antonov An-225', 320, 4),
(6, 'Airbus A321', 185, 2),
(7, 'Embraer E175', 76, 5),
(8, 'Boeing 737 MAX 8', 166, 5),
(9, 'Boeing 737-800', 189, 10),
(10, 'Boeing 737-700', 126, 10),
(11, 'Airbus A340-600', 350, 11);

-- INSERTS VUELOS 
INSERT INTO Vuelos (ID, Origen, Destino, Fecha_Hora_Salida, Fecha_Hora_Llegada, Asientos_Disponibles, Precio, Avion_ID) VALUES 
(1, 'Madrid', 'Paris', '2025-08-09 08:00:00', '2025-08-09 10:00:00', 150, 200.50, 1),
(2, 'London', 'New York', '2025-08-10 14:00:00', '2025-08-10 17:00:00', 200, 350.75, 2),
(3, 'Tokyo', 'Sydney', '2025-08-11 06:00:00', '2025-08-11 15:00:00', 180, 450.00, 3),
(4, 'Dubai', 'London', '2025-08-12 12:00:00', '2025-08-12 16:00:00', 220, 300.25, 4),
(5, 'Paris', 'Rome', '2025-08-13 09:00:00', '2025-08-13 11:00:00', 130, 150.00, 5),
(6, 'New York', 'Los Angeles', '2025-08-14 07:00:00', '2025-08-14 10:00:00', 190, 250.50, 6),
(7, 'Sydney', 'Singapore', '2025-08-15 13:00:00', '2025-08-15 16:00:00', 160, 400.75, 7),
(8, 'Berlin', 'Madrid', '2025-08-16 10:00:00', '2025-08-16 12:00:00', 140, 180.00, 8),
(9, 'Rome', 'Athens', '2025-08-17 08:00:00', '2025-08-17 09:30:00', 120, 120.50, 9),
(10, 'Los Angeles', 'San Francisco', '2025-08-18 14:00:00', '2025-08-18 15:00:00', 170, 150.25, 10),
(15, 'Singapore', 'Tokyo', '2025-08-19 06:00:00', '2025-08-19 09:00:00', 200, 350.00, 11);

-- INSERTS PASAJEROS
OPEN SYMMETRIC KEY ClaveAerolinia
DECRYPTION BY CERTIFICATE CertificadoCifrado;
INSERT INTO Pasajeros (ID, Nombre, Apellido1, Apellido2, Cedula, Email, Telefono) VALUES
(1, 'Viviana', 'Porras', 'Corella', EncryptByKey(Key_GUID('ClaveAerolinia'), '22345676'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'viviana@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '6324-0101')),
(2, 'Sujey', 'Reyes', 'Lopez', EncryptByKey(Key_GUID('ClaveAerolinia'), '47654321'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'sujey@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '8896-0132')),
(3, 'Naraly', 'Trigueros', 'Rodriguez', EncryptByKey(Key_GUID('ClaveAerolinia'), '81223344'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'naraly@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '9086-0203')),
(4, 'Barbara', 'Rodriguez', 'Martinez', EncryptByKey(Key_GUID('ClaveAerolinia'), '44332211'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'barbara@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '6345-2304')),
(5, 'Mariangel', 'Martinez', 'Cruz', EncryptByKey(Key_GUID('ClaveAerolinia'), '55667788'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'mariangel@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '4564-0102')),
(6, 'Sofia', 'Cruz', 'Vega', EncryptByKey(Key_GUID('ClaveAerolinia'), '88990011'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'sofia.cruz@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '9384-0105')),
(7, 'Cesar', 'Porras', 'Corella', EncryptByKey(Key_GUID('ClaveAerolinia'), '99001122'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'cesar@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '70394-01503')),
(8, 'Denia', 'Corella', 'Fernandez', EncryptByKey(Key_GUID('ClaveAerolinia'), '22113344'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'denia@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '8093-0101')),
(9, 'Miguel', 'Ruiz', 'Diaz', EncryptByKey(Key_GUID('ClaveAerolinia'), '33445566'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'miguel@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '8895-94943')),
(10, 'Maripaz', 'Diaz', 'Morales', EncryptByKey(Key_GUID('ClaveAerolinia'), '66778899'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'maripaz@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '9284-02321')),
(11, 'Cristian', 'Morales', 'Ortiz', EncryptByKey(Key_GUID('ClaveAerolinia'), '77889900'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'cristian@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '9288-0513')),
(12, 'John', 'Porras', 'Corella', EncryptByKey(Key_GUID('ClaveAerolinia'), '88001122'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'john@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '7187-0150')),
(13, 'Ronald', 'Porras', 'Hernandez', EncryptByKey(Key_GUID('ClaveAerolinia'), '99112233'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'ronald@gmail.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '60394-0114')),
(14, 'Ingrid', 'Torres', 'Ramos', EncryptByKey(Key_GUID('ClaveAerolinia'), '11224455'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'ingrid@email.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '8374-0112')),
(15, 'Guilberto', 'Ramos', 'Flores', EncryptByKey(Key_GUID('ClaveAerolinia'), '33446677'), EncryptByKey(Key_GUID('ClaveAerolinia'), 'gilberto@email.com'), EncryptByKey(Key_GUID('ClaveAerolinia'), '6093-0115'));

CLOSE SYMMETRIC KEY ClaveAerolinia;



-- INSERTS RESERVAS 
INSERT INTO Reservas (ID, Fecha_Reserva, Estado, Asiento, Pasajero_ID, Vuelo_ID) VALUES
(1, '2025-08-01', 'Confirmada', '12A', 1, 1),
(2, '2025-08-02', 'Confirmada', '15B', 2, 2),
(3, '2025-08-03', 'Pendiente', '10C', 3, 3),
(4, '2025-08-04', 'Confirmada', '22A', 4, 4),
(5, '2025-08-05', 'Cancelada', '18D', 5, 5),
(6, '2025-08-06', 'Confirmada', '25E', 6, 6),
(7, '2025-08-07', 'Pendiente', '5A', 7, 7),
(8, '2025-08-08', 'Confirmada', '8B', 8, 8),
(9, '2025-08-09', 'Confirmada', '30F', 9, 9),
(10, '2025-08-10', 'Cancelada', '14C', 10, 10),
(11, '2025-08-11', 'Cancelada', '16A', 11, 1),
(12, '2025-08-12', 'Pendiente', '9D', 12, 2),
(13, '2025-08-13', 'Confirmada', '20B', 13, 3),
(14, '2025-08-14', 'Confirmada', '11E', 14, 4),
(15, '2025-08-15', 'Confirmada', '7A', 15, 5);


-- INSERTS PAGOS
INSERT INTO Pagos (ID, Monto, Metodo_Pago, Fecha_Pago, Estado, Reserva_ID) VALUES
(1, 200.50, 'Tarjeta de Credito', '2025-08-01', 'Completado', 1),
(2, 350.75, 'Tarjeta de Debito', '2025-08-02', 'Completado', 2),
(3, 450.00, 'Transferencia', '2025-08-03', 'Pendiente', 3),
(4, 300.25, 'Tarjeta de Credito', '2025-08-04', 'Completado', 4),
(5, 150.00, 'SIMPE', '2025-08-05', 'Fallido', 5),
(6, 250.50, 'Tarjeta de Credito', '2025-08-06', 'Completado', 6),
(7, 400.75, 'Transferencia', '2025-08-07', 'Pendiente', 7),
(8, 180.00, 'Tarjeta de Debito', '2025-08-08', 'Completado', 8),
(9, 120.50, 'Tarjeta de Credito', '2025-08-09', 'Completado', 9),
(10, 150.25, 'Transferencia Bancaria', '2025-08-10', 'cancelado', 10),
(11, 350.00, 'Tarjeta de Credito', '2025-08-11', 'Completado', 11),
(12, 200.75, 'Transferencia', '2025-08-12', 'Pendiente', 12),
(13, 180.50, 'Tarjeta de Debito', '2025-08-13', 'Cancelado', 13),
(14, 300.00, 'Tarjeta de Credito', '2025-08-14', 'Completado', 14),
(15, 150.75, 'SIMPE', '2025-08-15', 'Completado', 15);

-- CREAR ROLES
CREATE ROLE Administrador_Rol;
CREATE ROLE Usuario_Rol;

-- PERMISOS ADMINISTRADOR
GRANT CONTROL ON DATABASE::SistemaVuelosS TO Administrador_Rol;

-- PERMISOS DE USUARIO
GRANT SELECT, INSERT, UPDATE ON Vuelos TO Usuario_Rol;
GRANT SELECT, INSERT, UPDATE ON Reservas TO Usuario_Rol;
GRANT SELECT, INSERT, UPDATE ON Pagos TO Usuario_Rol;
GRANT SELECT ON Aerolinia TO Usuario_Rol;
GRANT SELECT ON Aviones TO Usuario_Rol;
GRANT SELECT, INSERT ON Pasajeros TO Usuario_Rol;
GO

