USE Tejuana;

/*****************************************************************************************************************/
# ShippingList
/*****************************************************************************************************************/

DROP PROCEDURE IF EXISTS Tejuana.ShippingList;
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

/*****************************************************************************************************************/
# PickUpList
/*****************************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.PickUpList;
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
