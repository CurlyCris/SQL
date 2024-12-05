-------EJERCICIO 1
-- Crear una tabla llamada "Clientes" con las columnas: id (entero, clave primaria), nombre (texto) y email (texto).
CREATE TABLE IF NOT EXISTS Clientes (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL
)
--Insertar un nuevo cliente en la tabla "Clientes" con id=1, nombre="Juan" y email=" juan@example.com".
INSERT INTO clientes(id, nombre, email)
VALUES (1, 'Juan', 'juan@example.com')
--  Actualizar el email del cliente con id=1 a " juan@gmail.com".
UPDATE clientes
SET email = 'juan@gmail.com'
WHERE id = 1
-- Eliminar el cliente con id=1 de la tabla "Clientes".
DELETE FROM public.clientes
WHERE id = 1;
-- Crear una tabla llamada "Pedidos" con las columnas: id (entero, clave primaria), cliente_id (entero, clave externa referenciando a la tabla "Clientes"), producto (texto) y cantidad (entero).
CREATE TABLE IF NOT EXISTS Pedidos (
	id SERIAL PRIMARY KEY,
	cliente_id INT NOT NULL,
	producto VARCHAR (255) NOT NULL,
	cantidad INT NOT NULL,
	FOREIGN KEY (cliente_id) REFERENCES public.clientes(id) 
)
--  Insertar un nuevo pedido en la tabla "Pedidos" con id=1, cliente_id=1, producto="Camiseta" y cantidad=2.
INSERT INTO pedidos (id, cliente_id, producto, cantidad)
VALUES (1, 1, 'Camiseta', 2)
-- Actualizar la cantidad del pedido con id=1 a 3.
UPDATE pedidos
SET id = 3
WHERE id = 1
--Eliminar el pedido con id=1 de la tabla "Pedidos".
DELETE FROM public.pedidos
WHERE id = 1
-- Crear una tabla llamada "Productos" con las columnas: id (entero, clave primaria), nombre (texto) y precio (decimal).
CREATE TABLE IF NOT EXISTS Productos(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	precio DECIMAL
)
--Insertar varios productos en la tabla "Productos" con diferentes valores.
INSERT INTO public.productos (nombre, precio) 
VALUES 
    ('chaqueta', 25),
    ('pantalón', 30),
    ('camiseta', 15),
    ('zapatos', 50)
-- Consultar todos los clientes de la tabla "Clientes".
SELECT * FROM public.clientes
-- Consultar todos los pedidos de la tabla "Pedidos" junto con los nombres de los clientes correspondientes.
SELECT * FROM public.clientes
LEFT JOIN public.pedidos
ON public.pedidos.cliente_id = public.clientes.id
-- Consultar los productos de la tabla "Productos" cuyo precio sea mayor a $50.
SELECT * FROM public.productos
WHERE precio >= 50
--Consultar los pedidos de la tabla "Pedidos" que tengan una cantidad mayor o igual a 5.
SELECT * FROM public.pedidos
WHERE cantidad >= 5
-- Consultar los clientes de la tabla "Clientes" cuyo nombre empiece con la letra "A".
SELECT * FROM public.clientes
WHERE nombre ILIKE 'a%'
-- Realizar una consulta que muestre el nombre del cliente y el total de pedidos realizados por cada cliente.
SELECT clientes.nombre, clientes.email, pedidos.cantidad AS "Numero de pedidos" FROM public.clientes
LEFT JOIN public.pedidos
ON public.clientes.id = public.pedidos.cliente_id
-- Realizar una consulta que muestre el nombre del producto y la cantidad total de pedidos de ese producto.
SELECT pedidos.producto AS "Nombre de producto",
SUM(cantidad) AS "cantidad total"
FROM public.pedidos
GROUP BY pedidos.producto
--Agregar una columna llamada "fecha" a la tabla "Pedidos" de tipo fecha.
ALTER TABLE pedidos
ADD COLUMN Fecha DATE
--Agregar una clave externa a la tabla "Pedidos" que haga referencia a la tabla "Productos" en la columna "producto".
ALTER TABLE productos
RENAME COLUMN nombre TO producto
-
ALTER TABLE productos
ADD CONSTRAINT unique_producto UNIQUE (producto)
-
ALTER TABLE pedidos
	ADD CONSTRAINT FK_producto
	FOREIGN KEY (producto) REFERENCES productos(producto)
--Realizar una consulta que muestre los nombres de los clientes, los nombres de los productos y las cantidades de los pedidos donde coincida la clave externa.
SELECT clientes.nombre, productos.producto, pedidos.cantidad
FROM public.pedidos
LEFT JOIN productos
	ON pedidos.producto=productos.producto
LEFT JOIN clientes
	ON pedidos.cliente_id=clientes.id

------EJERCICIO 2
--Crea una base de datos llamada "MiBaseDeDatos".
CREATE DATABASE "MiBaseDeDatos"
--Crea una tabla llamada "Usuarios" con las columnas: "id" (entero, clave primaria), "nombre" (texto) y "edad" (entero).
CREATE TABLE IF NOT EXISTS Usuarios (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	edad INT NOT NULL
)
--Inserta dos registros en la tabla "Usuarios".
INSERT INTO usuarios(nombre, edad)
VALUES ('Paco', 23), ('Ana', 54)
--Actualiza la edad de un usuario en la tabla "Usuarios".
UPDATE usuarios
SET edad=21
WHERE nombre = 'Ana'
--Elimina un usuario de la tabla "Usuarios".
DELETE FROM public.usuarios 
WHERE id=2
--Crea una tabla llamada "Ciudades" con las columnas: "id" (entero, clave primaria), "nombre" (texto) y "pais" (texto).
CREATE TABLE IF NOT EXISTS Ciudades (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	pais VARCHAR(255) NOT NULL
)
-- Inserta al menos tres registros en la tabla "Ciudades".
INSERT INTO ciudades(nombre,pais)
VALUES ('Madrid','España'), ('Paris', 'France'), ('Shanghai','China')
--Crea una foreign key en la tabla "Usuarios" que se relacione con la columna "id" de la tabla "Ciudades".
ALTER TABLE usuarios
ADD COLUMN Ciudad_id INT
//
ALTER TABLE usuarios
ADD CONSTRAINT FK_ciudades
FOREIGN KEY (ciudad_id) REFERENCES ciudades(id)
--Realiza una consulta que muestre los nombres de los usuarios junto con el nombre de su ciudad y país (utiliza un LEFT JOIN).
SELECT usuarios.*, ciudades.nombre, ciudades.pais
FROM usuarios
LEFT JOIN ciudades
ON usuarios.ciudad_id=ciudades.id
-- Realiza una consulta que muestre solo los usuarios que tienen una ciudad asociada (utiliza un INNER JOIN).
SELECT * FROM usuarios
INNER JOIN ciudades
ON usuarios.ciudad_id=ciudades.id
--
-------EJERCICIO 3
--Crea una tabla llamada "Productos" con las columnas: "id" (entero, clave primaria), "nombre" (texto) y "precio" (numérico).
CREATE TABLE IF NOT EXISTS Productos(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	precio DECIMAL
)
--Inserta al menos cinco registros en la tabla "Productos".
INSERT INTO productos(nombre, precio)
VALUES ('naranja',3.50), ('manzana',7.60), ('kiwi', 2.40), ('mango',4.50), ('melon',6.20)
--Actualiza el precio de un producto en la tabla "Productos".
UPDATE productos
SET precio = 1.90
WHERE nombre='manzana'
-- Elimina un producto de la tabla "Productos".
DELETE FROM productos
WHERE nombre = 'melon'
-- Realiza una consulta que muestre los nombres de los usuarios junto con los nombres de los productos que han comprado (utiliza un INNER JOIN con la tabla "Productos").
ALTER TABLE usuarios
ADD COLUMN product_id INT,
ADD CONSTRAINT FK_producto
FOREIGN KEY (product_id) REFERENCES productos(id)
//
SELECT*FROM usuarios
INNER JOIN productos
ON usuarios.product_id=productos.id
--
------EJERCICIO 4
--Crea una tabla llamada "Pedidos" con las columnas: "id" (entero, clave primaria), "id_usuario" (entero, clave foránea de la tabla "Usuarios") y "id_producto" (entero, clave foránea de la tabla "Productos").
CREATE TABLE IF NOT EXISTS Pedidos(
	id SERIAL PRIMARY KEY,
	id_usuario INT,
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
	id_producto INT,
	FOREIGN KEY (id_producto) REFERENCES productos(id)
)
--Inserta al menos tres registros en la tabla "Pedidos" que relacionen usuarios con productos.
INSERT INTO pedidos(id_usuario,id_producto)
VALUES (1,2), (1,3), (3,4), (3,5), (4,3)
--Realiza una consulta que muestre los nombres de los usuarios y los nombres de los productos que han comprado, incluidos aquellos que no han realizado ningún pedido (utiliza LEFT JOIN y COALESCE
SELECT usuarios.nombre, COALESCE(productos.nombre, 'No ha comprado') AS producto
FROM usuarios
LEFT JOIN productos
ON usuarios.product_id=productos.id
LEFT JOIN pedidos
ON usuarios.id=pedidos.id_usuario
//
UPDATE usuarios 
SET product_id = pedidos.id_producto
FROM Pedidos
WHERE usuarios.id = pedidos.id_usuario
--Realiza una consulta que muestre los nombres de los usuarios que han realizado un pedido, pero también los que no han realizado ningún pedido (utiliza LEFT JOIN).
SELECT usuarios.nombre
FROM usuarios
LEFT JOIN pedidos
ON usuarios.id=pedidos.id_usuario
--Agrega una nueva columna llamada "cantidad" a la tabla "Pedidos" y actualiza los registros existentes con un valor (utiliza ALTER TABLE y UPDATE)
ALTER TABLE pedidos
ADD COLUMN cantidad INT
//
UPDATE Pedidos
SET cantidad = 1
--
------EJERCICIO 5
--Crea una tabla llamada "Clientes" con las columnas id (entero) y nombre (cadena de texto).
CREATE TABLE IF NOT EXISTS clientes(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL
)
--Inserta un cliente con id=1 y nombre='John' en la tabla "Clientes".
INSERT INTO clientes (nombre)
VALUES ('Jhon')
-- Actualiza el nombre del cliente con id=1 a 'John Doe' en la tabla "Clientes".
UPDATE clientes
SET nombre = 'John Doe'
WHERE id=1
--Elimina el cliente con id=1 de la tabla "Clientes".
DELETE FROM clientes
WHERE id=1
--Lee todos los clientes de la tabla "Clientes".
SELECT * FROM clientes
--Crea una tabla llamada "Pedidos" con las columnas id (entero) y cliente_id (entero).
CREATE TABLE IF NOT EXISTS pedidos(
	id SERIAL PRIMARY KEY,
	cliente_id INT
)
-- Inserta un pedido con id=1 y cliente_id=1 en la tabla "Pedidos".
INSERT INTO pedidos(cliente_id)
VALUES (1)
-- Actualiza el cliente_id del pedido con id=1 a 2 en la tabla "Pedidos".
UPDATE pedidos
SET cliente_id=2
WHERE id=1
--Elimina el pedido con id=1 de la tabla "Pedidos".
DELETE FROM pedidos
WHERE id=1
--Lee todos los pedidos de la tabla "Pedidos".
SELECT * FROM Pedidos
-- Crea una tabla llamada "Productos" con las columnas id (entero) y nombre (cadena de texto).
CREATE TABLE IF NOT EXISTS productos(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR (255) NOT NULL
)
--Inserta un producto con id=1 y nombre='Camisa' en la tabla "Productos".
INSERT INTO productos(id, nombre)
VALUES (1, 'Camisa')
-- Actualiza el nombre del producto con id=1 a 'Pantalón' en la tabla "Productos".
UPDATE productos
SET nombre = 'pantalón'
WHERE id = 1
-- Elimina el producto con id=1 de la tabla "Productos".
DELETE FROM productos
WHERE id = 1
-- Lee todos los productos de la tabla "Productos".
SELECT * FROM productos
--Crea una tabla llamada "DetallesPedido" con las columnas pedido_id (entero) y producto_id (entero).
CREATE TABLE IF NOT EXISTS DetallesPedido (
	pedido_id INT,
	producto_id INT
)
-- Inserta un detalle de pedido con pedido_id=1 y producto_id=1 en la tabla "DetallesPedido".
INSERT INTO detallespedido (pedido_id, producto_id)
VALUES (1,1)
--Actualiza el producto_id del detalle de pedido con pedido_id=1 a 2 en la tabla "DetallesPedido".
UPDATE Detallespedido
SET producto_id=2
WHERE pedido_id= 1
--Elimina el detalle de pedido con pedido_id=1 de la tabla "DetallesPedido".
DELETE FROM Detallespedido
WHERE pedido_id=1
--. Lee todos los detalles de pedido de la tabla "DetallesPedido".
SELECT * FROM Detallespedido
--Realiza una consulta para obtener todos los clientes y sus pedidos correspondientes utilizando un inner join.
UPDATE detallespedido
SET producto_id=productos.id
FROM productos
WHERE detallespedido.producto_id = productos.id
//
UPDATE detallespedido
SET pedido_id=pedidos.id
FROM pedidos
WHERE detallespedido.pedido_id = pedidos.id
//
ALTER TABLE detallespedido 
ADD CONSTRAINT FK_detallespedido
FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
//
ALTER TABLE detallespedido 
ADD CONSTRAINT FK_detallesproducto
FOREIGN KEY (producto_id) REFERENCES productos(id)
//
SELECT clientes.nombre, pedidos.*
FROM pedidos
INNER JOIN clientes
ON clientes.id=pedidos.cliente_id
-- Realiza una consulta para obtener todos los clientes y sus pedidos correspondientes utilizando un left join.
SELECT clientes.nombre, pedidos.*
FROM pedidos
LEFT JOIN clientes
ON clientes.id=pedidos.cliente_id
--Realiza una consulta para obtener todos los productos y los detalles de pedido correspondientes utilizando un inner join.
SELECT productos.nombre, detallespedido.*
FROM detallespedido
INNER JOIN productos
ON productos.id=detallespedido.producto_id
-- Realiza una consulta para obtener todos los productos y los detalles de pedido correspondientes utilizando un inner join.
SELECT productos.nombre, detallespedido.*
FROM detallespedido
LEFT JOIN productos
ON productos.id=detallespedido.producto_id
--Crea una nueva columna llamada "telefono" de tipo cadena de texto en la tabla "Clientes".
ALTER TABLE clientes
ADD COLUMN telefono VARCHAR (255)
--Modifica la columna "telefono" en la tabla "Clientes" para cambiar su tipo de datos a entero.
ALTER TABLE Clientes
ALTER COLUMN telefono TYPE INT
--Elimina la columna "telefono" de la tabla "Clientes".
ALTER TABLE clientes
DROP COLUMN telefono
--Cambia el nombre de la tabla "Clientes" a "Usuarios".
ALTER TABLE clientes
RENAME TO usuarios
--Cambia el nombre de la columna "nombre" en la tabla "Usuarios" a "nombre_completo".
ALTER TABLE usuarios
RENAME nombre TO nombre_completo
-- Agrega una restricción de clave primaria a la columna "id" en la tabla "Usuarios".
ALTER TABLE Usuarios
ADD CONSTRAINT pk_usuarios PRIMARY KEY (id) -- no me deja ejecutar porque ya hay una clave primaria