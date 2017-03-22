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

