USE Tejuana;

/****************************************************************************************************/
# ClientsBy
/****************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.ClientsBy;
CREATE PROCEDURE Tejuana.ClientsBy (search VARCHAR(255))
BEGIN
	SELECT
		*
	FROM 
		Tejuana.Client
	WHERE 
		client_name LIKE CONCAT('%', search, '%') OR
		client_email LIKE CONCAT('%', search, '%') OR
		client_phone LIKE CONCAT('%', search, '%');
END;

/****************************************************************************************************/
# AddressesBy
/****************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.AddressesBy;
CREATE PROCEDURE Tejuana.AddressesBy (search VARCHAR(255))
BEGIN
	SELECT
		ad.*
	FROM 
		Tejuana.Address AS ad,
		Tejuana.Client AS cl
	WHERE 
		cl.client_id = ad.client_id AND
		(cl.client_name LIKE CONCAT('%', search, '%') OR
		cl.client_email LIKE CONCAT('%', search, '%') OR
		cl.client_phone LIKE CONCAT('%', search, '%'));
END;

/****************************************************************************************************/
# SetDefaultAddress
/****************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.SetDefaultAddress;
CREATE PROCEDURE Tejuana.SetDefaultAddress (addressId INT, clientId INT)
BEGIN
	UPDATE
		Tejuana.Address
	SET 
		address_default = FALSE
	WHERE 
		client_id = clientId;

	UPDATE
		Tejuana.Address
	SET 
		address_default = TRUE
	WHERE 
		address_id = addressId;
END;

/****************************************************************************************************/
# InsertClient
/****************************************************************************************************/
 
DROP PROCEDURE IF EXISTS Tejuana.InsertClient;
CREATE PROCEDURE Tejuana.InsertClient (name VARCHAR(255), email VARCHAR(255), phone INT)
BEGIN
	INSERT INTO 
		Tejuana.Client (client_name, client_email, client_phone)
	VALUES
		(name, email, phone);

	SELECT last_insert_id();
END;