from model.order import *
from datetime import datetime
from components.jsonEncoder import MyEncoder

def orderListFactory(results):
	orders = []

	for row in results:	
		
		if row[4] is not None:
			dateStr = row[9].strftime("%Y-%m-%d %H:%M:%S")	
		else:
			dateStr = None

		orders.append(Order(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], dateStr))

	return MyEncoder().encode(orders)