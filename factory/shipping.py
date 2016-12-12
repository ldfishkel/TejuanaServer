from model.shipping import *
from components.jsonEncoder import MyEncoder

def shippingListFactory(results):
	shippings = []

	for row in results:	

		shippings.append(Shippng(row[0], row[1], row[2], row[3]))

	return MyEncoder().encode(shippings)

def shippingStatusFactory(results):
	shippingStatuses = []

	for row in results:	
		shippingStatuses.append(ShippingStatus(row[0], row[1]))

	return MyEncoder().encode(shippingStatuses)
