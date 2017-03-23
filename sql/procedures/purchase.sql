USE Tejuana;

/**************************************************************************************************************************/
# PurchaseList
/**************************************************************************************************************************/

DROP PROCEDURE IF EXISTS Tejuana.PurchaseList;
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


/**************************************************************************************************************************/
# CreatePurchase
/**************************************************************************************************************************/

DROP PROCEDURE IF EXISTS Tejuana.CreatePurchase;
CREATE PROCEDURE Tejuana.CreatePurchase (dueDate DATE, dueDateMax DATE, clientId INT, addressId INT, commissionMP NUMERIC(15, 2), discount NUMERIC(15, 2), shipping NUMERIC(15, 2), charged NUMERIC(15, 2), totalEarned NUMERIC(15, 2), via INT)
BEGIN
	DECLARE isShipping BOOLEAN;
	DECLARE purchaseId INT;

	SELECT 
		shipping IS NOT NULL AND shipping > 0 AND
		addressId IS NOT NULL AND addressId > 0 
	INTO 
		isShipping;

	INSERT INTO
		Tejuana.Purchase (
			purchase_due_date,
			purchase_due_date_max,
			purchase_charged,
			purchase_commission_mp,
			purchase_commission_shipping,
			purchase_discount,
			purchase_total_earned,
			purchase_shipping,
			client_id,
			purchase_via_id,
			purchase_status_id)
		VALUES (
			dueDate,
			dueDateMax,
			charged,
			commissionMP,
			shipping,
			discount,
			totalEarned,
			isShipping,
			clientId,
			via,
			1);

	SELECT last_insert_id() INTO purchaseId;

	IF isShipping THEN
		INSERT INTO
			Tejuana.Shipping (shipping_address, shipping_status_id, purchase_id)
		VALUES (addressId, 1, purchaseId);
	ELSE
		INSERT INTO
			Tejuana.Pick_Up (pick_up_locale, pick_up_status_id, purchase_id)
		VALUES ('FLORESTA', 1, purchaseId);
	END IF;

	SELECT purchaseId;
	
END;