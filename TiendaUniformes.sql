USE master;
GO
IF DB_ID (N'') IS NOT NULL
DROP DATABASE TiendaUniformes
GO
IF DB_ID (N'TiendaUniformes') IS NULL
CREATE DATABASE TiendaUniformes;
GO
USE TiendaUniformes;
GO
CREATE TABLE Account
(
	idU INT IDENTITY(1,1) PRIMARY KEY,
	userName VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	pass VARCHAR(100) NOT NULL,
	isActive BIT DEFAULT 1
);
GO
CREATE TABLE Customer
(
	idC INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	phone VARCHAR(10) NOT NULL,
	isActive BIT DEFAULT 1,
	createUser INT NOT NULL FOREIGN KEY REFERENCES Account(idU),
	createDate DATE NOT NULL,
	modifyUser INT FOREIGN KEY REFERENCES Account(idU),
	modifyDate DATE
)
GO
CREATE TABLE School
(
	idSc INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	isActive BIT DEFAULT 1,
	createUser INT NOT NULL FOREIGN KEY REFERENCES Account(idU),
	createDate DATE NOT NULL,
	modifyUser INT FOREIGN KEY REFERENCES Account(idU),
	modifyDate DATE
)
GO
CREATE TABLE Size
(
	idS INT IDENTITY(1,1) PRIMARY KEY,
	size INT NOT NULL,
	price DECIMAL(5,2) NOT NULL,
	isActive BIT DEFAULT 1,
	createUser INT NOT NULL FOREIGN KEY REFERENCES Account(idU),
	createDate DATE NOT NULL,
	modifyUser INT FOREIGN KEY REFERENCES Account(idU),
	modifyDate DATE
)
GO
CREATE TABLE Garment
(
	idG INT IDENTITY(1,1) PRIMARY KEY,
	type VARCHAR(50) NOT NULL,
	desctiption VARCHAR(200),
	idS INT NOT NULL FOREIGN KEY REFERENCES Size(idS),
	idSc INT NOT NULL FOREIGN KEY REFERENCES School(idSc),
	isActive BIT DEFAULT 1,
	createUser INT NOT NULL FOREIGN KEY REFERENCES Account(idU),
	createDate DATE NOT NULL,
	modifyUser INT FOREIGN KEY REFERENCES Account(idU),
	modifyDate DATE
)
GO
CREATE TABLE Inventory
(
	idI INT IDENTITY(1,1) PRIMARY KEY,
	idSc INT NOT NULL FOREIGN KEY REFERENCES Size(idS),
	idG INT NOT NULL FOREIGN KEY REFERENCES Garment(idG),
	quantitaty INT NOT NULL,
	isActive BIT DEFAULT 1,
	createUser INT NOT NULL FOREIGN KEY REFERENCES Account(idU),
	createDate DATE NOT NULL,
	modifyUser INT FOREIGN KEY REFERENCES Account(idU),
	modifyDate DATE
)
GO
CREATE TABLE [Order]
(
	idO INT IDENTITY(1,1) PRIMARY KEY,
	dateOrder DATE NOT NULL,
	deadLine DATE NOT NULL,
	idC INT NOT NULL FOREIGN KEY REFERENCES Customer(idC),
	totalPrice DECIMAL(5,2) NOT NULL,
	isActive BIT DEFAULT 1,
	createUser INT NOT NULL FOREIGN KEY REFERENCES Account(idU),
	createDate DATE NOT NULL,
	modifyUser INT FOREIGN KEY REFERENCES Account(idU),
	modifyDate DATE
)
GO
CREATE TABLE OrderDetail
(
	idOd INT IDENTITY(1,1) PRIMARY KEY,
	idO INT NOT NULL FOREIGN KEY REFERENCES [Order](idO),
	idG INT NOT NULL FOREIGN KEY REFERENCES Garment(idG),
	quantitaty INT NOT NULL,
	isActive BIT DEFAULT 1,
	createUser INT NOT NULL FOREIGN KEY REFERENCES Account(idU),
	createDate DATE NOT NULL,
	modifyUser INT FOREIGN KEY REFERENCES Account(idU),
	modifyDate DATE
)
GO

insert into Account (userName, email, pass)
values ('Juan', 'juancito@gmail.com', '123456'),
	   ('Sonia', 'sonia_fuentes33@gmail.com','fuentes987'),
	   ('Pedro', 'papacitopascal@yahoo.com', 'ILovePascal');
Go
insert into Size (size, price, createUser, createDate)
values (32, 220, 1, '2024-05-09'),
	   (26, 150, 3, '2024-05-09'),
	   (12, 120, 2, '2024-05-11'),
	   (28, 160, 3, '2024-05-13'),
	   (30, 200, 1, '2024-05-13'),
	   (14, 135, 2, '2024-05-14');
GO
insert into School (name, createUser, createDate)
values ('Miguel Hidalgo', 2, '2024-05-09'),
	   ('Venustiano Carranza', 1, '2024-05-10'),
	   ('Vicente Guerrero', 3, '2024-05-10'),
	   ('Lazaro Cardenaz', 1, '2024-05-12'),
	   ('Lucio Blanco', 3, '2024-05-12'),
	   ('Esc. Sec. Tecnica #29',2, '2024-05-14');
GO
insert into Customer (name, phone, createUser, createDate)
values ('Pablo Ramirez', '86623214569', 3, '2024-05-09'),
	   ('Marisol Ramos', '8661234567', 1, '2024-05-11'),
	   ('Evelin Barrera', '8662486351', 2, '2024-05-13');
GO
insert into Garment (type, desctiption, idS, idSc, createUser, createDate)
values ('Pantalon Invernal', 'Pantalon de tela gruesa para temporada de invierno', 3, 1, 2, '2024-05-12'),
	   ('Short', 'Short deportivo para clases de actividad fisica', 1, 4, 1, '2024-05-13'),
	   ('Chaquetin', 'Chaquetin para temporada de invierno', 4, 5, 3, '2024-05-14'),
	   ('Pantalon', 'Pantalon escolar', 3, 1, 2, '2024-05-12'),
	   ('Playera', 'Playera escolar', 1, 4, 1, '2024-05-13'),
	   ('Pantalon Invernal', 'Pantalon de tela gruesa para temporada de invierno', 4, 5, 3, '2024-05-14');
GO
insert into Inventory (idSc, idG, quantitaty, createUser, createDate)
values (3, 1, 18, 2, '2024-05-12'),
	   (1, 2, 15, 1, '2024-05-13'),
	   (4, 3, 20, 3, '2024-05-14');
GO
insert into [Order] (dateOrder, deadLine, idC, totalPrice, createUser, createDate)
values ('2024-05-14', '2024-05-18', 3, 240, 2, '2024-05-14'),
	   ('2024-05-14', '2024-05-18', 2, 000, 1, '2024-05-14'),
	   ('2024-05-14', '2024-05-18', 1, 000, 3, '2024-05-14');
GO
insert into OrderDetail (idO, idG, quantitaty, createUser, createDate)
values (1, 1, 2, 2, '2024-05-14'),
	   (1, 4, 2, 2, '2024-05-14'),
	   (2, 2, 1, 1, '2024-05-14'),
	   (2, 5, 2, 1, '2024-05-14'),
	   (3, 3, 1, 3, '2024-05-14'),
	   (3, 6, 1, 3, '2024-05-14');
GO
select * from Account
select * from Size
select * from School
select * from Customer
select * from Garment
select * from Inventory
select * from [Order]
select * from OrderDetail

