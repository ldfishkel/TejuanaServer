USE Tejuana;

/****************************************************************************************/
# OrderList
/****************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.OrderList;
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
		
END;

/****************************************************************************************/
# OrderReady
/****************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.OrderReady;
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
END;