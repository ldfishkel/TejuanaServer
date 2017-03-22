USE Tejuana;

/******************************************************************************************************************************/
# InsertProduct
/******************************************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.InsertProduct;
CREATE PROCEDURE Tejuana.InsertProduct (prodName VARCHAR(100), price NUMERIC(15,2), size VARCHAR(10), typeId INT, avgTime INT, stock INT)
BEGIN
	INSERT INTO 
		Tejuana.Product (product_name, product_cost, product_size, product_type_id, product_tejuar_avg, product_stock) 
	VALUES
		(prodName, price, size, typeId, avgTime, product_stock);
	
	SELECT last_insert_id();
END;

/******************************************************************************************************************************/
# UpdateProduct
/******************************************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.UpdateProduct;
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
END;

/******************************************************************************************************************************/
# InsertProductType
/******************************************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.InsertProductType;
CREATE PROCEDURE Tejuana.InsertProductType (prodTypeName VARCHAR(50))
BEGIN
	INSERT INTO 
		Tejuana.Product_Type (product_type_name)
	VALUES
		(prodTypeName);
	
	SELECT last_insert_id();
END;

/******************************************************************************************************************************/
# ProductListBy
/******************************************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.ProductListBy;
CREATE PROCEDURE Tejuana.ProductListBy (prodType INT)
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
		INNER JOIN Tejuana.Product_Type AS pt ON p.product_type_id = pt.product_type_id
	WHERE
		pt.product_type_id = prodType;

/******************************************************************************************************************************/
# ProductList 	*View*
/******************************************************************************************************************************/
 
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