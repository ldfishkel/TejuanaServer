import MySQLdb
from logger.logger import *

def connect():
	return MySQLdb.connect("localhost", "root", "root", "Tejuana")

def query(queryStr):
	db = connect()
	cursor = db.cursor()

	try:
		logQuery(queryStr)
		cursor.execute(queryStr)
		results = cursor.fetchall()
		cursor.close()
		db.close()
		return results

	except MySQLdb.Error, e:	
		cursor.close()
		db.close()
		raise InternalServerError("Error en la base de datos. \n" + errorMessage(e))

def errorMessage(e):
	try:
		msg = "Error [%d]: %s" % (e.args[0], e.args[1])
	except IndexError:
		msg = "Error: %s" % str(e)

	logErrorMsg(msg)
	return msg




