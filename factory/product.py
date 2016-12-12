from model.product import *
from components.jsonEncoder import MyEncoder

def productListFactory(results, images):

	products = []
	lastId = 0
	product = None

	for row in results:

		if (row[0] == lastId) and (product is not None):
			if row[7] and row[8] and row[9]:
				product.Supplies.append(ProductSupply(row[7], row[8], row[9]))
		else:
			lastId = row[0]
			product = Product(row[0], row[1], ProductType(row[2], row[3]), row[4], row[5], row[6], row[10])
			if row[7] and row[8] and row[9]:
				product.Supplies.append(ProductSupply(row[7], row[8], row[9]))
			products.append(product)

	return MyEncoder().encode(map(lambda x : addImages(x, images), products))


def addImages(product, images):
	for image in images:
		if (image[1] == product.Id):
			product.Images.append(image[2])
	return product

def productTypeListFactory(results):

	prodTypes = []

	for row in results:
		prodTypes.append(ProductType(row[0], row[1]))

	return MyEncoder().encode(prodTypes)

def productSuppliesListFactory(results):
	productSupplies = []

	for row in results:
		productSupplies.append(ProductSupply(row[0], row[1], 0))

	return MyEncoder().encode(productSupplies)

def tagFactory(results):
	tags = []

	for row in results:
		tags.append(Tag(row[0], row[1]))

	return MyEncoder().encode(tags)