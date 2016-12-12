import MySQLdb

from dataAccess import *
from logger.logger import *
from rest.httpError import InternalServerError

def insertSupplyMov(supplyMov):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "CALL Tejuana.InsertSupplyMov({0}, {1}, {2})".format(supplyMov["SupplyId"], supplyMov["Amount"], supplyMov["Price"])
		
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

def insertSupply(supply):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "INSERT INTO Tejuana.Supply(supply_name) VALUES ('{0}')".format(supply["Name"])
		
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