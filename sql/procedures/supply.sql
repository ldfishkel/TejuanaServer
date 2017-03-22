USE Tejuana;

/*****************************************************************************/
# InsertSupplyMov
/*****************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.InsertSupplyMov;
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
END;

/*****************************************************************************/
# ProductSuppliesList     *View*
/*****************************************************************************/
 
DROP VIEW IF EXISTS Tejuana.ProductSuppliesList;
CREATE VIEW Tejuana.ProductSuppliesList AS
    SELECT 
        s.supply_id, s.supply_name
    FROM
        Tejuana.Supply AS s;	

/*****************************************************************************/
# SupplyDataList    *View*
/*****************************************************************************/
 
DROP VIEW IF EXISTS Tejuana.SupplyDataList;
CREATE VIEW Tejuana.SupplyDataList AS
    SELECT 
        s.*,
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
					            GROUP BY 
					            	sp.supply_id), 0)) AS realstock
    FROM
        Tejuana.Supply AS s;	


/*****************************************************************************/
# ConsumeSupply   *Trigger*
/*****************************************************************************/
 
DROP TRIGGER IF EXISTS Tejuana.ConsumeSupply;
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
END;

/*****************************************************************************/
# NeddedSupply   *Trigger*
/*****************************************************************************/
 
DROP TRIGGER IF EXISTS Tejuana.NeddedSupply;
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
END;