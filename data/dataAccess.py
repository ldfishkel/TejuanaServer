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

		db.close()
		
		return results

	except MySQLdb.Error, e:	
		logError(e[0], e[1])

	db.close()

	return results




