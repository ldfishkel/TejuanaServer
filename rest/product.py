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

class ProductsByType:
	def GET(self, prodType):		
		results = query("call Tejuana.ProductListBy({0})".format(prodType))
		return productListFactory(results)

class Product:
	def GET(self):		
		results = query("select * from Tejuana.ProductList")
		return productListFactory(results)

	def POST(self):
		data = web.data()
		logPayload(data)
		product = json.loads(data)
		validateProduct(product)
		insertProduct(product)

	def PUT(self):
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