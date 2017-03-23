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
CREATE PROCEDURE Tejuana.CreatePurchase (dueDate DATE, dueDateMax DATE, clientId INT, commissionMP NUMERIC(15, 2), discount NUMERIC(15, 2), shipping NUMERIC(15, 2), charged NUMERIC(15, 2), totalEarned NUMERIC(15, 2), via INT)
BEGIN
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
			(SELECT shipping IS NOT NULL),
			clientId,
			via,
			1);

	SELECT last_insert_id();
END;