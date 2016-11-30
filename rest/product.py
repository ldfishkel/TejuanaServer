import web
import json

from data.dataAccess import *
from data.product import *
from factory.product import *
from logger.logger import *

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

		if validateProduct(product):
			updateProduct(product, productId)
		else:
			logError("Error producto invalido")
			

################################################################################
#VALIDATORS
################################################################################

def validateProduct(product):
	return True