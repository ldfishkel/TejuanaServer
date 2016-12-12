from model.supply import *
from datetime import datetime
from components.jsonEncoder import MyEncoder

def supplyDataListFactory(results):
	supplies = []
	
	for row in results:	
		
		if row[3] is not None:
			dateStr = row[3].strftime("%Y-%m-%d %H:%M:%S")	
		else:
			dateStr = None

		supplies.append(SupplyData(row[0], row[1], row[2], str(row[4]), dateStr))

	return MyEncoder().encode(supplies)

def supplyListFactory(results):
	supplies = []

	for row in results:		
		supplies.append(Supply(row[0], row[1]))

	return MyEncoder().encode(supplies)
