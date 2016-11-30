USE Tejuana;

/****************************************************************************************************************/
/**PROPIEDADES DE TRANSACCIONES**/
/****************************************************************************************************************/
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

/****************************************************************************************************************/
/**BORRAR TABLAS**/
/****************************************************************************************************************/
DROP TABLE IF EXISTS Tejuana.Client_Detail;
DROP TABLE IF EXISTS Tejuana.Client;
DROP TABLE IF EXISTS Tejuana.Product_Supply;
DROP TABLE IF EXISTS Tejuana.Supply;
DROP TABLE IF EXISTS Tejuana.Product;
DROP TABLE IF EXISTS Tejuana.Product_Type;

/****************************************************************************************************************/
/**CREAR TABLAS**/
/****************************************************************************************************************/
CREATE TABLE IF NOT EXISTS Tejuana.Client (
	client_id INT AUTO_INCREMENT,
	cleint_fb_id INT,
	client_fb_string_id VARCHAR(255),
	client_name VARCHAR(255) NOT NULL,
	client_points INT NOT NULL DEFAULT 0,
	PRIMARY KEY (client_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Client_Detail (
	client_detail_id INT NOT NULL,
	client_detail_dni INT NOT NULL,
	client_detail_address VARCHAR(255),
	client_detail_zipcode VARCHAR(20),
	FOREIGN KEY (client_detail_id) REFERENCES Tejuana.Client(client_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Product_Type (
	product_type_id INT AUTO_INCREMENT,
	product_type_name VARCHAR(50),
	PRIMARY KEY (product_type_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Product (
	product_id INT AUTO_INCREMENT,
	product_name VARCHAR(100) NOT NULL,
	product_cost NUMERIC(15,2) NOT NULL,
	product_size VARCHAR(10),
	product_type_id INT,
	product_tejuar_avg INT NOT NULL,
	product_image VARCHAR(255) NOT NULL,
	PRIMARY KEY (product_id),
	FOREIGN KEY (product_type_id) REFERENCES Tejuana.Product_Type(product_type_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Supply (
	supply_id INT AUTO_INCREMENT,
	supply_name VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY (supply_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Product_Supply (
	product_id INT NOT NULL,
	supply_id INT NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY (product_id, supply_id),
	FOREIGN KEY (product_id) REFERENCES Tejuana.Product(product_id),
	FOREIGN KEY (supply_id) REFERENCES Tejuana.Supply(supply_id)
);
DROP VIEW IF EXISTS Tejuana.ProductList;
CREATE VIEW Tejuana.ProductList
AS 
	SELECT
		p.product_id,
		p.product_name,
		pt.product_type_id,
		pt.product_type_name,
		p.product_image,
		p.product_tejuar_avg,
		p.product_cost,
		p.product_size,
		s.supply_id,
		s.supply_name,
		ps.quantity
	FROM
		Tejuana.Product AS p,
		Tejuana.Product_Type AS pt,
		Tejuana.Product_Supply AS ps,
		Tejuana.Supply AS s
	WHERE
		p.product_type_id = pt.product_type_id AND
		p.product_id = ps.product_id AND
		s.supply_id = ps.supply_id;


DROP VIEW IF EXISTS Tejuana.ProductSuppliesList;
CREATE VIEW Tejuana.ProductSuppliesList
AS 
	SELECT		
		s.supply_id,
		s.supply_name
	FROM
		Tejuana.Supply AS s;		


DROP PROCEDURE IF EXISTS Tejuana.ProductListBy;
CREATE PROCEDURE Tejuana.ProductListBy (prodType INT)
	SELECT
		p.product_id,
		p.product_name,
		pt.product_type_id,
		pt.product_type_name,
		p.product_image,
		p.product_tejuar_avg,
		p.product_cost,
		p.product_size,
		s.supply_id,
		s.supply_name,
		ps.quantity
	FROM
		Tejuana.Product AS p,
		Tejuana.Product_Type AS pt,
		Tejuana.Product_Supply AS ps,
		Tejuana.Supply AS s
	WHERE
		p.product_type_id = pt.product_type_id AND
		p.product_id = ps.product_id AND
		s.supply_id = ps.supply_id AND
		pt.product_type_id = prodType;


DROP PROCEDURE IF EXISTS Tejuana.InsertProduct;
DELIMITER //
CREATE PROCEDURE Tejuana.InsertProduct (prodName VARCHAR(100), price NUMERIC(15,2), size VARCHAR(10), typeId INT, avgTime INT, imageUrl VARCHAR(255))
BEGIN
	INSERT INTO 
		Tejuana.Product (product_name, product_cost, product_size, product_type_id, product_tejuar_avg, product_image) 
	VALUES
		(prodName, price, size, typeId, avgTime, imageUrl);

	SELECT LAST_INSERT_ID();
END //
DELIMITER ;

INSERT INTO Tejuana.Product_Type VALUES (1, 'Leodan');
INSERT INTO Tejuana.Product VALUES (1, 'Leodan deluxe', 300, 'XL', 1, 120, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product VALUES (2, 'Leodan platinum', 350, 'XL', 1, 120, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');
INSERT INTO Tejuana.Supply VALUES (1, 'Hilo Rojo');
INSERT INTO Tejuana.Supply VALUES (2, 'Hilo Crudo');
INSERT INTO Tejuana.Supply VALUES (3, 'Hilo Amarillo');
INSERT INTO Tejuana.Product_Supply VALUES (1, 1, 50);
INSERT INTO Tejuana.Product_Supply VALUES (1, 2, 150);
INSERT INTO Tejuana.Product_Supply VALUES (2, 3, 50);
INSERT INTO Tejuana.Product_Supply VALUES (2, 2, 150);

INSERT INTO Tejuana.Product_Type VALUES (2, 'Top Mery');
INSERT INTO Tejuana.Product VALUES (3, 'Top Mery Rosa', 200, 'S', 2, 100, 'https://scontent-gru2-1.xx.fbcdn.net/v/t1.0-0/p480x480/15219369_1352039674815664_2465993764460513865_n.jpg?oh=416acbb69780bd6cd6136b26bf6c0ee3&oe=58BDB101');
INSERT INTO Tejuana.Product VALUES (4, 'Top Mery Crudo', 220, 'M', 2, 100, 'https://fb-s-c-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15094480_1343335192352779_4701827482473836564_n.jpg?oh=bb52701e6900cc4555ca72bc96d6ee24&oe=58BA51D4&__gda__=1488906051_5454fcbb81a6f36764bdc17204ab98b6');
INSERT INTO Tejuana.Supply VALUES (4, 'Hilo Rosa');
INSERT INTO Tejuana.Product_Supply VALUES (3, 4, 200);
INSERT INTO Tejuana.Product_Supply VALUES (4, 2, 250);





