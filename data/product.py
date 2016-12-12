import MySQLdb

from dataAccess import *
from logger.logger import *
from rest.httpError import InternalServerError

def insertProduct(product):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "CALL Tejuana.InsertProduct('{0}', {1}, '{2}', {3}, {4}, '{5}', {6})".format(product["Name"], product["Price"], product["Size"], product["Type"]["Id"], product["AvgProductionTime"], product["ImageURL"], product["Stock"])
		
		logQuery(sql)
		cursor.execute(sql)
		prodId = int(cursor.fetchone()[0])
		logLastInseted(prodId)
		
		if product["Supplies"]:
			cursor.close()
			cursor = db.cursor()
			sql = None
			
			for supply in product["Supplies"]:
				
				if sql is None:
					sql = "INSERT INTO Tejuana.Product_Supply VALUES ({0}, {1}, {2})".format(prodId, supply["Id"], supply["Amount"])
				else:
					sql = sql + ",({0}, {1}, {2})".format(prodId, supply["Id"], supply["Amount"])

			logQuery(sql)
			cursor.execute(sql)

		if product["Images"]:
			cursor.close()
			cursor = db.cursor()
			sql = None
			
			for image in product["Images"]:
				
				if sql is None:
					sql = "INSERT INTO Tejuana.Product_Image (product_id, product_image_url) VALUES ({0}, '{1}')".format(prodId, image)
				else:
					sql = sql + ",({0}, '{1}')".format(prodId, image)

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

def updateProduct(product):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "CALL Tejuana.UpdateProduct({0}, '{1}', {2}, '{3}', {4}, {5}, '{6}')".format(product["Id"], product["Name"], product["Price"], product["Size"], product["Type"]["Id"], product["AvgProductionTime"], product["Stock"])

		logQuery(sql)
		cursor.execute(sql)
		

		sql = "DELETE FROM Tejuana.Product_Supply WHERE product_id = {0}".format(product["Id"])

		cursor.close()
		cursor = db.cursor()
		logQuery(sql)
		cursor.execute(sql)

		if product["Supplies"]:
			cursor.close()
			cursor = db.cursor()
			sql = None
			
			for supply in product["Supplies"]:
				
				if sql is None:
					sql = "INSERT INTO Tejuana.Product_Supply VALUES ({0}, {1}, {2})".format(product["Id"], supply["Id"], supply["Amount"])
				else:
					sql = sql + ",({0}, {1}, {2})".format(product["Id"], supply["Id"], supply["Amount"])

			logQuery(sql)
			cursor.execute(sql)

		if product["Images"]:
			cursor.close()
			cursor = db.cursor()
			sql = "DELETE FROM Tejuana.Product_Image WHERE product_id = {0}".format(product["Id"])

			cursor.close()
			cursor = db.cursor()
			logQuery(sql)
			cursor.execute(sql)

			sql = None
			
			for image in product["Images"]:
				
				if sql is None:
					sql = "INSERT INTO Tejuana.Product_Image (product_id, product_image_url) VALUES ({0}, '{1}')".format(product["Id"], image)
				else:
					sql = sql + ",({0}, '{1}')".format(product["Id"], image)

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

def insertTag(tag):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "INSERT INTO Tejuana.Tag (tag_name) VALUES ('{0}')".format(tag["Name"])

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

def insertProductType(productType):
	db = connect()
	cursor = db.cursor()

	try:
		sql = "Call Tejuana.InsertProductType('{0}')".format(productType["Name"])

		logQuery(sql)
		cursor.execute(sql)
		productTypeId = int(cursor.fetchone()[0])
		cursor.close()
		logLastInseted(productTypeId)
		
		sql = None
		
		for tag in productType["Tags"]:
			
			if sql is None:
				sql = "INSERT INTO Tejuana.Product_Type_Tag VALUES ({0}, {1})".format(productTypeId, tag["Id"])
			else:
				sql = sql + ",({0}, {1})".format(productTypeId, tag["Id"])

		logQuery(sql)
		cursor = db.cursor()
		cursor.execute(sql)
		db.commit()
		cursor.close()
		db.close()
	except MySQLdb.Error, e:
		db.rollback()
		cursor.close()
		db.close()
		raise InternalServerError("Error en la base de datos. \n" + errorMessage(e))