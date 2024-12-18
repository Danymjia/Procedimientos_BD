CREATE DATABASE Procedimientos;
USE Procedimientos;

CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  
    Nombre VARCHAR(100),                      
    Estatura DECIMAL(5,2),                    
    FechaNacimiento DATE,                     
    Sueldo DECIMAL(10,2)                     
);

-- Insertar Datos en la Tabla
DELIMITER //
CREATE PROCEDURE InsertarCliente(
    IN nombreCliente VARCHAR(100),
    IN estaturaCliente DECIMAL(5,2),
    IN fechaNacimientoCliente DATE,
    IN sueldoCliente DECIMAL(10,2)
)
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (nombreCliente, estaturaCliente, fechaNacimientoCliente, sueldoCliente);
END //
DELIMITER ;

CALL InsertarCliente('Juan Pérez', 1.75, '1990-05-15', 3000.50);

CALL SeleccionarClientes();

-- Actualizar Datos en la Tabla
DELIMITER //
CREATE PROCEDURE ActualizarCliente(
    IN idCliente INT,
    IN nuevoSueldo DECIMAL(10,2)
)
BEGIN
    UPDATE cliente
    SET Sueldo = nuevoSueldo
    WHERE ClienteID = idCliente;
END //
DELIMITER ;

CALL ActualizarCliente(1, 3500.00);

-- Eliminar Datos de la Tabla

DELIMITER //
CREATE PROCEDURE EliminarCliente(
    IN idCliente INT
)
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = idCliente;

    -- Mostrar los datos restantes
    SELECT * FROM cliente;
END //
DELIMITER ;

CALL EliminarCliente(1);


-- Uso de IF
DELIMITER //
CREATE PROCEDURE VerificarEdad(
    IN fechaNacimiento DATE
)
BEGIN
    IF (YEAR(CURDATE()) - YEAR(fechaNacimiento)) >= 22 THEN
        SELECT 'Mayor o igual a 22 años';
    ELSE
        SELECT 'Menor de 22 años';
    END IF;
END //
DELIMITER ;

CALL VerificarEdad('2000-01-01');

-- Creación de la Tabla de Órdenes CON RELACIÓN CON EL CLIENTE - FORANEA

CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    FechaOrden DATE,
    Monto DECIMAL(10,2),
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);

-- Procedimientos de Órdenes -Insertar Orden
DELIMITER //
CREATE PROCEDURE InsertarOrden(
    IN idCliente INT,
    IN fechaOrden DATE,
    IN montoOrden DECIMAL(10,2)
)
BEGIN
    INSERT INTO ordenes (ClienteID, FechaOrden, Monto)
    VALUES (idCliente, fechaOrden, montoOrden);
END //
DELIMITER ;

-- Procedimientos  Actualizar Orden
DELIMITER //
CREATE PROCEDURE ActualizarOrden(
    IN idOrden INT,
    IN nuevoMonto DECIMAL(10,2)
)
BEGIN
    UPDATE ordenes
    SET Monto = nuevoMonto
    WHERE OrdenID = idOrden;
END //
DELIMITER ;

-- Procedimientos Eliminar Orden
DELIMITER //
CREATE PROCEDURE EliminarOrden(
    IN idOrden INT
)
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = idOrden;
END //
DELIMITER ;










