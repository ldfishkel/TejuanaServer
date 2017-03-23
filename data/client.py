import MySQLdb

from dataAccess import *
from logger.logger import *
from rest.httpError import InternalServerError

def updateClient(client):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "CALL Tejuana.SetDefaultAddress({0}, {1})".format(client["DefaultAddress"]["Id"], client["Id"])
		
		logQuery(sql)
		cursor.execute(sql)
		
		db.commit()
		cursor.close()
		db.close()
	
	except MySQLdb.Error, e:
		db.rollback()
		cursor.close()
		db.close()
		raise InternalServerError("Error en la base de datos. \n" + errorMessage(e))

def insertClient(client):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "Call Tejuana.InsertClient('{0}', '{1}', '{2}')".format(client["Name"], client["Email"], client["Phone"])

		logQuery(sql)
		cursor.execute(sql)
		insertedId = int(cursor.fetchone()[0])
		logLastInseted(insertedId)
		
		if client["Addresses"]:
			cursor.close()
			cursor = db.cursor()
			sql = None
			
			for address in client["Addresses"]:
				
				if sql is None:
					sql = "INSERT INTO Tejuana.Address (address_address, address_zipcode, address_province, address_region, address_district, address_default, client_id) VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', {5}, {6})".format(address["Address"], address["Zipcode"], address["Province"], address["Region"], address["District"], address["Default"], insertedId)
				else:
					sql = sql + ",({'{0}', '{1}', '{2}', '{3}', '{4}', {5}, {6})".format(address["Address"], address["Zipcode"], address["Province"], address["Region"], address["District"], address["Default"], insertedId)

			logQuery(sql)
			cursor.execute(sql)
		
		cursor.close()
		db.commit()
		db.close()
	
	except MySQLdb.Error, e:
		db.rollback()
		cursor.close()
		db.close()
		raise InternalServerError("Error en la base de datos. \n" + errorMessage(e))
	

