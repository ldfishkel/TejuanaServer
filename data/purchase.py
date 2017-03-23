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

def insertPurchase(purchase):
	db = connect()
	cursor = db.cursor()

	try:
		print purchase["DueDate"]
		sql = "CALL Tejuana.CreatePurchase('{0}', '{1}', {2}, {3}, {4}, {5}, {6}, {7}, {8})".format(purchase["DueDate"], purchase["DueDateMax"], purchase["Client"], purchase["CommissionMP"], purchase["Discount"], purchase["Shipping"], purchase["Charged"], purchase["TotalEarned"], purchase["Via"])

		logQuery(sql)
		cursor.execute(sql)
		insertedId = int(cursor.fetchone()[0])
		logLastInseted(insertedId)
		
		if purchase["Orders"]:
			cursor.close()
			cursor = db.cursor()
			sql = None
			
			for order in purchase["Orders"]:
				
				if sql is None:
					sql = "INSERT INTO Tejuana.Order (order_amount, order_ready, order_cancelled, product_id, purchase_id) VALUES ({0}, {1}, {2}, {3}, {4})".format(order["Amount"], 0, 0, order["Product"], insertedId, order["Product"])
				else:
					sql = sql + ",({0}, {1}, {2}, {3}, {4})".format(order["Amount"], 0, 0, order["Product"], insertedId, order["Product"])

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
	

