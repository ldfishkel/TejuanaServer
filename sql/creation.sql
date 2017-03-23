DROP DATABASE IF EXISTS Tejuana;

CREATE DATABASE Tejuana;

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
DROP TABLE IF EXISTS Tejuana.Address;
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
    client_phone VARCHAR(50),
    PRIMARY KEY (client_id)
);

CREATE TABLE IF NOT EXISTS Tejuana.Address (
	address_id INT AUTO_INCREMENT,
	address_address VARCHAR(255) NOT NULL,
	address_zipcode VARCHAR(20) NOT NULL,
	address_province VARCHAR(50),
	address_region VARCHAR(50),
	address_district VARCHAR(50),
	address_default BOOLEAN DEFAULT FALSE,
	client_id INT NOT NULL,
	PRIMARY KEY (address_id),
	FOREIGN KEY (client_id)
		REFERENCES Tejuana.Client (client_id)
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
	purchase_due_date_max DATE,
    
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

    shipping_address INT NOT NULL,
	
	shipping_status_id INT NOT NULL,
    purchase_id INT NOT NULL,

    PRIMARY KEY (shipping_id),
    FOREIGN KEY (shipping_status_id)
        REFERENCES Tejuana.Shipping_Status(shipping_status_id),
    FOREIGN KEY (purchase_id)
        REFERENCES Tejuana.Purchase (purchase_id),
    FOREIGN KEY (shipping_address)
        REFERENCES Tejuana.Address (address_id)
);

CREATE TABLE Tejuana.ThrowException (
	error_msg VARCHAR(255) NOT NULL,
	PRIMARY KEY(error_msg)
);