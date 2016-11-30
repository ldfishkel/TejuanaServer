import MySQLdb

from dataAccess import *
from logger.logger import *

def insertProduct(product):

	db = connect()
	cursor = db.cursor()

	try:
		sql = "CALL Tejuana.InsertProduct('{0}', {1}, '{2}', {3}, {4}, '{5}', {6})".format(product["Name"], product["Price"], product["Size"], product["Type"]["Id"], product["AvgProductionTime"], product["ImageURL"], product["Stock"])
		
		logQuery(sql)

		cursor.execute(sql)
		
		prodId = int(cursor.fetchone()[0])

		logLastInseted(prodId)
		
		sql = None
		
		for supply in product["Supplies"]:
			
			if sql is None:
				sql = "INSERT INTO Tejuana.Product_Supply VALUES ({0}, {1}, {2})".format(prodId, supply["Id"], supply["Amount"])
			else:
				sql = sql + ",({0}, {1}, {2})".format(prodId, supply["Id"], supply["Amount"])

		print sql

		cursor.close()
		
		cursor = db.cursor()
		
		logQuery(sql)

		cursor.execute(sql)

		db.commit()
	
	except MySQLdb.Error, e:
		
		logError(e[0], e[1])
		db.rollback()

	db.close()

def updateProduct(product, productId):
	
	db = connect()
	cursor = db.cursor()

	try:
		sql = "CALL Tejuana.UpdateProduct({0}, '{1}', {2}, '{3}', {4}, {5}, '{6}', {7})".format(productId, product["Name"], product["Price"], product["Size"], product["Type"]["Id"], product["AvgProductionTime"], product["ImageURL"], product["Stock"])

		logQuery(sql)
		
		cursor.execute(sql)

		cursor.close()

		cursor = db.cursor()

		sql = "DELETE FROM Tejuana.Product_Supply WHERE product_id = {0}".format(productId)

		logQuery(sql)

		cursor.execute(sql)

		sql = None
		
		for supply in product["Supplies"]:
			
			if sql is None:
				sql = "INSERT INTO Tejuana.Product_Supply VALUES ({0}, {1}, {2})".format(productId, supply["Id"], supply["Amount"])
			else:
				sql = sql + ",({0}, {1}, {2})".format(productId, supply["Id"], supply["Amount"])

		cursor.close()

		cursor = db.cursor()

		logQuery(sql)

		cursor.execute(sql)

		db.commit()
	
	except MySQLdb.Error, e:
		
		logError(e[0], e[1])
		db.rollback()

	db.close()