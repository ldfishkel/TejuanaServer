from model.product import *
from components.jsonEncoder import MyEncoder

def productListFactory(results):
	
	products = []
	lastId = 0
	product = None

	for row in results:

		if (row[0] == lastId) and (product is not None):
			product.Supplies.append(Supply(row[8], row[9], row[10]))
		else:
			lastId = row[0]
			product = Product(row[0], row[1], ProductType(row[2], row[3]), row[4], row[5], row[6], row[7], row[11])
			product.Supplies.append(Supply(row[8], row[9], row[10]))
			products.append(product)

	return MyEncoder().encode(products)

def productTypeListFactory(results):

	prodTypes = []

	for row in results:
		prodTypes.append(ProductType(row[0], row[1]))

	return MyEncoder().encode(prodTypes)

def productSuppliesListFactory(results):
	productSupplies = []

	for row in results:
		productSupplies.append(Supply(row[0], row[1], 0))

	return MyEncoder().encode(productSupplies)