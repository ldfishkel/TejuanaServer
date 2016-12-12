import MySQLdb

from dataAccess import *
from logger.logger import *
from rest.httpError import InternalServerError

def orderReady(orderId):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "CALL Tejuana.OrderReady({0})".format(orderId)
		
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
