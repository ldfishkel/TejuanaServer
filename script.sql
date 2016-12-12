USE Tejuana;

/****************************************************************************************************************/
/******************************************PROPIEDADES DE TRANSACCIONES******************************************/
/****************************************************************************************************************/

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

/****************************************************************************************************************/
/******************************************BORRAR TABLAS*********************************************************/
/****************************************************************************************************************/

DROP TABLE IF EXISTS Tejuana.Pick_Up;
DROP TABLE IF EXISTS Tejuana.Pick_Up_Status;
DROP TABLE IF EXISTS Tejuana.Shipping;
DROP TABLE IF EXISTS Tejuana.Shipping_Status;

DROP TABLE IF EXISTS Tejuana.Order;
DROP TABLE IF EXISTS Tejuana.Purchase;
DROP TABLE IF EXISTS Tejuana.Purchase_Status;
DROP TABLE IF EXISTS Tejuana.Purchase_Via;
DROP TABLE IF EXISTS Tejuana.Client;

DROP TABLE IF EXISTS Tejuana.Product_Supply;
DROP TABLE IF EXISTS Tejuana.Supply_Stock_Mov;
DROP TABLE IF EXISTS Tejuana.Supply;
DROP TABLE IF EXISTS Tejuana.Product_Image;
DROP TABLE IF EXISTS Tejuana.Product;
DROP TABLE IF EXISTS Tejuana.Product_Type_Tag;
DROP TABLE IF EXISTS Tejuana.Product_Type;
DROP TABLE IF EXISTS Tejuana.Tag;

DROP TABLE IF EXISTS Tejuana.ThrowException;


/****************************************************************************************************************/
CREATE TABLE IF NOT EXISTS Tejuana.Product_Type (
    product_type_id INT AUTO_INCREMENT,
    product_type_name VARCHAR(50) UNIQUE,
    PRIMARY KEY (product_type_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Product (
    product_id INT AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    product_cost NUMERIC(15 , 2 ) NOT NULL,
    product_size VARCHAR(10),
    product_type_id INT,
    product_stock INT NOT NULL,
    product_tejuar_avg INT NOT NULL,
    PRIMARY KEY (product_id),
    FOREIGN KEY (product_type_id)
        REFERENCES Tejuana.Product_Type (product_type_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Product_Image (
    product_image_id INT AUTO_INCREMENT,
	product_id INT NOT NULL,
	product_image_url VARCHAR(255) NOT NULL,
    PRIMARY KEY (product_image_id),
	FOREIGN KEY (product_id)
        REFERENCES Tejuana.Product (product_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Supply (
    supply_id INT AUTO_INCREMENT,
    supply_name VARCHAR(50) NOT NULL UNIQUE,
    supply_stock INT NOT NULL,
    supply_last_date DATETIME,
    PRIMARY KEY (supply_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Product_Supply (
    product_id INT NOT NULL,
    supply_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (product_id , supply_id),
    FOREIGN KEY (product_id)
        REFERENCES Tejuana.Product (product_id),
    FOREIGN KEY (supply_id)
        REFERENCES Tejuana.Supply (supply_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Supply_Stock_Mov (
    supply_stock_mov_id INT NOT NULL AUTO_INCREMENT,
    supply_id INT NOT NULL,
    supply_stock_mov_amount INT NOT NULL,
    supply_stock_mov_price INT NOT NULL,
    supply_stock_mov_date DATETIME NOT NULL,
    PRIMARY KEY (supply_stock_mov_id),
    FOREIGN KEY (supply_id)
        REFERENCES Tejuana.Supply (supply_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Tag (
    tag_id INT AUTO_INCREMENT,
    tag_name VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY (tag_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Product_Type_Tag (
    product_type_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (product_type_id , tag_id),
    FOREIGN KEY (product_type_id)
        REFERENCES Tejuana.Product_Type (product_type_id),
    FOREIGN KEY (tag_id)
        REFERENCES Tejuana.Tag (tag_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Client (
    client_id INT AUTO_INCREMENT,
    client_name VARCHAR(255) NOT NULL,
    client_email VARCHAR(255),
    client_phone INT,
    client_document INT,
    PRIMARY KEY (client_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Purchase_Status (
    purchase_status_id INT AUTO_INCREMENT,
    purchase_status_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (purchase_status_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Purchase_Via (
    purchase_via_id INT AUTO_INCREMENT,
    purchase_via_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (purchase_via_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Purchase (
    purchase_id INT AUTO_INCREMENT,
    
	purchase_due_date DATE,
    
	purchase_charged NUMERIC(15, 2) NOT NULL DEFAULT 0,
	purchase_commission_mp NUMERIC(15, 2) NOT NULL DEFAULT 0,
	purchase_commission_shipping NUMERIC(15, 2 ) NOT NULL DEFAULT 0,
	purchase_discount NUMERIC(15, 2) NOT NULL DEFAULT 0,
	purchase_total_earned NUMERIC(15, 2) NOT NULL DEFAULT 0,
    purchase_shipping BOOLEAN,
    
	client_id INT NOT NULL,
    purchase_via_id INT NOT NULL,
    purchase_status_id INT NOT NULL,
    
    PRIMARY KEY (purchase_id),
    FOREIGN KEY (client_id)
        REFERENCES Tejuana.Client (client_id),
    FOREIGN KEY (purchase_status_id)
        REFERENCES Tejuana.Purchase_Status (purchase_status_id),
	FOREIGN KEY (purchase_via_id)
        REFERENCES Tejuana.Purchase_Via (purchase_via_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Order (
    order_id INT NOT NULL AUTO_INCREMENT,
    
	order_amount INT NOT NULL,
    order_ready BOOLEAN NOT NULL,
	order_cancelled BOOLEAN NOT NULL,

	product_id INT NOT NULL,
    purchase_id INT NOT NULL,

    PRIMARY KEY (order_id),
    FOREIGN KEY (product_id)
        REFERENCES Tejuana.Product (product_id),
    FOREIGN KEY (purchase_id)
        REFERENCES Tejuana.Purchase (purchase_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Pick_Up_Status (
    pick_up_status_id INT AUTO_INCREMENT,
    pick_up_status_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (pick_up_status_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Pick_Up (
    pick_up_id INT NOT NULL AUTO_INCREMENT,
    pick_up_locale VARCHAR(20) NOT NULL CHECK (pick_up_locale IN ('FLORESTA', 'PALERMO')),
	
	pick_up_status_id INT NOT NULL,
    purchase_id INT NOT NULL,

    PRIMARY KEY (pick_up_id),
    FOREIGN KEY (pick_up_status_id)
        REFERENCES Tejuana.Pick_Up_Status(pick_up_status_id),
    FOREIGN KEY (purchase_id)
        REFERENCES Tejuana.Purchase (purchase_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Shipping_Status (
    shipping_status_id INT AUTO_INCREMENT,
    shipping_status_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (shipping_status_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Shipping (
    shipping_id INT NOT NULL AUTO_INCREMENT,

    shipping_address VARCHAR(255) NOT NULL,
	
	shipping_status_id INT NOT NULL,
    purchase_id INT NOT NULL,

    PRIMARY KEY (shipping_id),
    FOREIGN KEY (shipping_status_id)
        REFERENCES Tejuana.Shipping_Status(shipping_status_id),
    FOREIGN KEY (purchase_id)
        REFERENCES Tejuana.Purchase (purchase_id)
);

CREATE TABLE Tejuana.ThrowException (
	error_msg VARCHAR(255) NOT NULL,
	PRIMARY KEY(error_msg)
);
/***********************************************************************************************************/
/***************************** VIEWS FUNCTIONS PROCEDURES **************************************************/
/***********************************************************************************************************/

DROP VIEW IF EXISTS Tejuana.ProductList;
CREATE VIEW Tejuana.ProductList AS
    SELECT 
        p.product_id,
        p.product_name,
        pt.product_type_id,
        pt.product_type_name,
        p.product_tejuar_avg,
        p.product_cost,
        p.product_size,
        s.supply_id,
        s.supply_name,
        ps.quantity,
        p.product_stock
    FROM
        Tejuana.Product AS p
		LEFT JOIN Tejuana.Product_Supply AS ps ON p.product_id = ps.product_id
		LEFT JOIN Tejuana.Supply AS s ON s.supply_id = ps.supply_id
		INNER JOIN Tejuana.Product_Type AS pt ON p.product_type_id = pt.product_type_id;

DROP VIEW IF EXISTS Tejuana.ProductSuppliesList;
CREATE VIEW Tejuana.ProductSuppliesList AS
    SELECT 
        s.supply_id, s.supply_name
    FROM
        Tejuana.Supply AS s;	

DROP VIEW IF EXISTS Tejuana.SupplyDataList;
CREATE VIEW Tejuana.SupplyDataList AS
    SELECT 
        s . *,
        s.supply_stock - (IFNULL((SELECT 
                        SUM(ps.quantity * o.order_amount)
                    FROM
                        Tejuana.Order as o,
                        Tejuana.Product_Supply as ps
                    WHERE
                        o.product_id = ps.product_id
                            AND ps.supply_id = s.supply_id
                            AND o.order_ready = FALSE
                    GROUP BY ps.supply_id),
                0) - IFNULL((SELECT 
                SUM(p.product_stock * sp.quantity)
            FROM
                Tejuana.Product p,
                Tejuana.Product_Supply sp
            WHERE
                sp.product_id = p.product_id
                    AND sp.supply_id = s.supply_id
            GROUP BY sp.supply_id), 0)) AS realstock
    FROM
        Tejuana.Supply AS s;	


DROP PROCEDURE IF EXISTS Tejuana.ProductListBy;
DELIMITER //
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
		ps.quantity,
		p.product_stock
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
// DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.ShippingList;
DELIMITER //
CREATE PROCEDURE Tejuana.ShippingList (statusId INT)
    SELECT 
        s.shipping_id,
		s.shipping_address,
		s.purchase_id,
		ss.shipping_status_name
    FROM
        Tejuana.Shipping AS s
		INNER JOIN Tejuana.Shipping_Status AS ss ON s.shipping_status_id = ss.shipping_status_id
	WHERE
		ss.shipping_status_id = statusId;
// DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.PickUpList;
DELIMITER //
CREATE PROCEDURE Tejuana.PickUpList (statusId INT)
    SELECT 
        p.pick_up_id,
		p.purchase_id,
		ss.pick_up_status_name
    FROM
        Tejuana.Pick_Up AS p
		INNER JOIN Tejuana.Pick_Up_Status AS ss ON p.pick_up_status_id = ss.pick_up_status_id
	WHERE
		ss.pick_up_status_id = statusId;
// DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.PurchaseList;
DELIMITER //
CREATE PROCEDURE Tejuana.PurchaseList (statusId INT)
    SELECT 
        p.purchase_id,
		p.purchase_due_date,
		ss.purchase_status_name
    FROM
        Tejuana.Purchase AS p
		INNER JOIN Tejuana.Purchase_Status AS ss ON p.purchase_status_id = ss.purchase_status_id
	WHERE
		ss.purchase_status_id = statusId;
// DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.InsertSupplyMov;
DELIMITER //
CREATE PROCEDURE Tejuana.InsertSupplyMov (supplyId INT, amount INT, price INT)
BEGIN
	INSERT INTO 
		Tejuana.Supply_Stock_Mov (supply_id, supply_stock_mov_amount, supply_stock_mov_price, supply_stock_mov_date) 
	VALUES
		(supplyId, amount, price, NOW());
	
	UPDATE
		Tejuana.Supply
	SET
		supply_stock = supply_stock + amount,
		supply_last_date = NOW()
	WHERE 
		supply_id = supplyId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.InsertProduct;
DELIMITER //
CREATE PROCEDURE Tejuana.InsertProduct (prodName VARCHAR(100), price NUMERIC(15,2), size VARCHAR(10), typeId INT, avgTime INT, stock INT)
BEGIN
	INSERT INTO 
		Tejuana.Product (product_name, product_cost, product_size, product_type_id, product_tejuar_avg, product_stock) 
	VALUES
		(prodName, price, size, typeId, avgTime, product_stock);
	
	SELECT last_insert_id();
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.UpdateProduct;
DELIMITER //
CREATE PROCEDURE Tejuana.UpdateProduct (prodId INT, prodName VARCHAR(100), price NUMERIC(15,2), size VARCHAR(10), typeId INT, avgTime INT, stock INT)
BEGIN
	UPDATE 
		Tejuana.Product
	SET
		product_name = prodName,
		product_cost = price,
		product_size = size,
		product_type_id = typeId,
		product_tejuar_avg = avgTime,
		product_stock = stock
	WHERE
		product_id = prodId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.InsertProductType;
DELIMITER //
CREATE PROCEDURE Tejuana.InsertProductType (prodTypeName VARCHAR(50))
BEGIN
	INSERT INTO 
		Tejuana.Product_Type (product_type_name)
	VALUES
		(prodTypeName);
	
	SELECT last_insert_id();
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.OrderList;
DELIMITER //
CREATE PROCEDURE Tejuana.OrderList ()
BEGIN
	SELECT
		o.order_id,
		pu.purchase_id,
		c.client_id,
		c.client_name,
		p.product_id,
		p.product_name,
		p.product_stock,
		pt.product_type_name,
		o.order_amount,
		pu.purchase_due_date		
	FROM
		Tejuana.Order as o,
		Tejuana.Purchase as pu,
		Tejuana.Client as c,
		Tejuana.Product as p,
		Tejuana.Product_Type pt
	WHERE
		o.purchase_id = pu.purchase_id AND
		pu.purchase_status_id IN (1, 3) AND
		c.client_id = pu.client_id AND
		p.product_id = o.product_id AND
		p.product_type_id = pt.product_type_id AND
		o.order_ready = FALSE;
		
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS Tejuana.OrderReady;
DELIMITER //
CREATE PROCEDURE Tejuana.OrderReady (orderId INT)
BEGIN

	SELECT
		@amount := order_amount,
		@productId := product_id
	FROM 
		Tejuana.Order
	WHERE 
		order_id = orderId;

	UPDATE
		Tejuana.Order
	SET
		order_ready = TRUE
	WHERE 
		order_id = orderId;

	UPDATE
		Tejuana.Product
	SET
		product_stock = product_stock - @amount
	WHERE
		product_id = @productId;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS Tejuana.ConsumeSupply;
DELIMITER //
CREATE TRIGGER Tejuana.ConsumeSupply AFTER UPDATE ON Tejuana.Product
FOR EACH ROW 
BEGIN

	DECLARE supplyId INT;
	DECLARE quant INT;
	DECLARE v_finished INTEGER DEFAULT 0;
	DECLARE cur CURSOR FOR SELECT supply_id, quantity FROM Tejuana.Product_Supply WHERE product_id = NEW.product_id;	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

    IF (OLD.product_stock < NEW.product_stock) THEN
		
		OPEN cur;

		get_supply: LOOP
		 
			FETCH cur INTO supplyId, quant;
			 
			IF v_finished = 1 THEN 
				LEAVE get_supply;
			END IF;
			 
			UPDATE
				Tejuana.Supply
			SET 
				supply_stock = supply_stock - (quant * (NEW.product_stock - OLD.product_stock))

			WHERE
				supply_id = supplyId;

		END LOOP get_supply;
		 
		CLOSE cur;
		
    END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS Tejuana.NeddedSupply;
DELIMITER //
CREATE TRIGGER Tejuana.NeddedSupply BEFORE UPDATE ON Tejuana.Product
FOR EACH ROW 
BEGIN
	DECLARE msg VARCHAR(255) DEFAULT "";
	DECLARE supplyId INT;
	DECLARE quant INT;
	DECLARE stock INT;
	DECLARE v_finished INTEGER DEFAULT 0;
	DECLARE cur CURSOR FOR SELECT supply_id, quantity FROM Tejuana.Product_Supply WHERE product_id = NEW.product_id;	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
	

    IF (OLD.product_stock < NEW.product_stock) THEN
		
		OPEN cur;

		get_supply: LOOP
		 
			FETCH cur INTO supplyId, quant;
			 
			IF v_finished = 1 THEN 
				LEAVE get_supply;
			END IF;
			
			SELECT 
				supply_stock
			INTO 
				stock
			FROM
				Tejuana.Supply
			WHERE 
				supply_id = supplyId;

			IF (stock < (quant * (NEW.product_stock - OLD.product_stock))) THEN
				
				INSERT INTO Tejuana.ThrowException VALUES ('No se puede actualizar el stock sin los insumos necesarios correspondientes');
		
			END IF;

		END LOOP get_supply;
		 
		CLOSE cur;
		
    END IF;
END //
DELIMITER ;

/***********************************************************************************************************/
/*************************************** SEED **************************************************************/
/***********************************************************************************************************/

INSERT INTO Tejuana.Product_Type VALUES (1, 'Leodan');
INSERT INTO Tejuana.Product VALUES (1, 'Leodan deluxe', 300, 'XL', 1, 0, 120);
INSERT INTO Tejuana.Product VALUES (2, 'Leodan platinum', 350, 'XL', 1, 0, 120);
INSERT INTO Tejuana.Supply VALUES (1, 'Hilo Rojo', 0, NULL);
INSERT INTO Tejuana.Supply VALUES (2, 'Hilo Crudo', 0, NULL);
INSERT INTO Tejuana.Supply VALUES (3, 'Hilo Amarillo', 0, NULL);
-- INSERT INTO Tejuana.Product_Supply VALUES (1, 1, 50);
-- INSERT INTO Tejuana.Product_Supply VALUES (1, 2, 150);
INSERT INTO Tejuana.Product_Supply VALUES (2, 3, 50);
INSERT INTO Tejuana.Product_Supply VALUES (2, 2, 150);

INSERT INTO Tejuana.Product_Type VALUES (2, 'Top Mery');
INSERT INTO Tejuana.Product VALUES (3, 'Top Mery Rosa', 200, 'S', 2, 0, 100);
INSERT INTO Tejuana.Product VALUES (4, 'Top Mery Crudo', 220, 'M', 2, 0, 100);
INSERT INTO Tejuana.Supply VALUES (4, 'Hilo Rosa', 0, NULL);
INSERT INTO Tejuana.Product_Supply VALUES (3, 4, 200);
INSERT INTO Tejuana.Product_Supply VALUES (4, 2, 250);

INSERT INTO Tejuana.Product_Image VALUES (1, 1, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (2, 1, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');
INSERT INTO Tejuana.Product_Image VALUES (3, 2, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (4, 2, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');
INSERT INTO Tejuana.Product_Image VALUES (5, 3, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (6, 3, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');
INSERT INTO Tejuana.Product_Image VALUES (7, 4, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (8, 4, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');


INSERT INTO Tejuana.Tag VALUES (1, 'verano');
INSERT INTO Tejuana.Tag VALUES (2, 'invierno');
INSERT INTO Tejuana.Tag VALUES (3, 'top');
INSERT INTO Tejuana.Tag VALUES (4, 'colorido');
INSERT INTO Tejuana.Tag VALUES (5, 'calor');
INSERT INTO Tejuana.Tag VALUES (6, 'playa');

INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 1);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 3);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 5);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 2);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 4);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 5);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 6);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 4);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 3);

INSERT INTO Tejuana.Purchase_Via VALUES (1, 'Web');
INSERT INTO Tejuana.Purchase_Via VALUES (2, 'Facebook');
INSERT INTO Tejuana.Purchase_Via VALUES (3, 'Instagram');
INSERT INTO Tejuana.Purchase_Via VALUES (4, 'MercadoLibre');
INSERT INTO Tejuana.Purchase_Via VALUES (5, 'Other');

INSERT INTO Tejuana.Purchase_Status VALUES (1, 'Orden Generada');
INSERT INTO Tejuana.Purchase_Status VALUES (2, 'Orden Cancelada');
INSERT INTO Tejuana.Purchase_Status VALUES (3, 'Pago');
INSERT INTO Tejuana.Purchase_Status VALUES (4, 'Enviado');
INSERT INTO Tejuana.Purchase_Status VALUES (5, 'Retirado');
INSERT INTO Tejuana.Purchase_Status VALUES (6, 'Calificado');

INSERT INTO Tejuana.Shipping_Status VALUES (1, 'En Produccion');
INSERT INTO Tejuana.Shipping_Status VALUES (2, 'Listo Para Enviar');
INSERT INTO Tejuana.Shipping_Status VALUES (3, 'Enviado');
INSERT INTO Tejuana.Shipping_Status VALUES (4, 'Recibido');
INSERT INTO Tejuana.Shipping_Status VALUES (5, 'Rebotado');
INSERT INTO Tejuana.Shipping_Status VALUES (6, 'Cancelado');

INSERT INTO Tejuana.Pick_Up_Status VALUES (1, 'En Produccion');
INSERT INTO Tejuana.Pick_Up_Status VALUES (2, 'Listo Para Retirar');
INSERT INTO Tejuana.Pick_Up_Status VALUES (3, 'Retirado');
INSERT INTO Tejuana.Pick_Up_Status VALUES (4, 'Cancelado');
INSERT INTO Tejuana.Pick_Up_Status VALUES (5, 'Rebotado');

INSERT INTO Tejuana.Client VALUES (1, 'Pepito1', 'pepito1@jose.com', 123456781, 36157481);
INSERT INTO Tejuana.Client VALUES (2, 'Pepito2', 'pepito2@jose.com', 123456782, 36157482);
INSERT INTO Tejuana.Client VALUES (3, 'Pepito3', 'pepito3@jose.com', 123456783, 36157483);


INSERT INTO Tejuana.ThrowException VALUES ('No se puede actualizar el stock sin los insumos necesarios correspondientes');

INSERT INTO Tejuana.Purchase VALUES (1, '2017-1-1', 500, 50, 50, 0, 400, TRUE, 1, 1, 1);
INSERT INTO Tejuana.Purchase VALUES (2, '2017-1-1', 500, 50, 0, 0, 450, FALSE, 1, 1, 1);

INSERT INTO Tejuana.Shipping VALUES (1, 'Correct Address string', 1, 1);
INSERT INTO Tejuana.Pick_Up VALUES (1, 'PALERMO', 1, 2);

INSERT INTO Tejuana.Order VALUES (1, 5, FALSE, FALSE, 2, 1);
INSERT INTO Tejuana.Order VALUES (2, 5, FALSE, FALSE, 3, 1);
INSERT INTO Tejuana.Order VALUES (3, 5, FALSE, FALSE, 4, 1);
    
INSERT INTO Tejuana.Order VALUES (4, 5, FALSE, FALSE, 1, 2);
INSERT INTO Tejuana.Order VALUES (5, 5, FALSE, FALSE, 2, 2);
INSERT INTO Tejuana.Order VALUES (6, 5, FALSE, FALSE, 3, 2);
    



