import web
import json

from data.dataAccess import *
from data.product import *
from factory.product import *
from logger.logger import *
from httpError import *

class ProductTypeList:
	def GET(self):
		results = query("select * from Tejuana.Product_Type")
		return productTypeListFactory(results)

class ProductList:            
    def GET(self):		
		results = query("select * from Tejuana.ProductList")
		return productListFactory(results)


class ProductListBy:           
    def GET(self, prodType):		
		results = query("call Tejuana.ProductListBy({0})".format(prodType))
		return productListFactory(results)

class ProductSupplies:
	def GET(self):
		results = query("select * from Tejuana.ProductSuppliesList")
		return productSuppliesListFactory(results)

class Tags:
	def GET(self):
		results = query("select * from Tejuana.Tag")
		return tagFactory(results)

	def POST(self):
		data = web.data()
		logPayload(data)
		tag = json.loads(data)
		insertTag(tag)


class AddProduct:
    def POST(self):
        
		data = web.data()

		logPayload(data)

		product = json.loads(data)

		if validateProduct(product):
			insertProduct(product)
		else:
			logError("Error producto invalido")

class UpdateProduct:
	def POST(self, productId):

		data = web.data()

		logPayload(data)

		product = json.loads(data)

		validateProduct(product)
		
		updateProduct(product, productId)
		

class AddProductType:
	def POST(self):
		data = web.data()
		logPayload(data)
		productType = json.loads(data)
		insertProductType(productType)
			

################################################################################
#VALIDATORS
################################################################################

def validateProduct(product):
	if (product["Name"] == "hola"):
		raise BadRequest("Producto invalido: No puede llamarse hola")