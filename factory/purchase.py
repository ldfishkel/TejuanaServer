from model.purchase import *
from components.jsonEncoder import MyEncoder

def purchaseListFactory(results):
	purhcases = []

	for row in results:

		if row[1] is not None:
			dateStr = row[1].strftime("%Y-%m-%d %H:%M:%S")	
		else:
			dateStr = None	

		purhcases.append(Purchase(row[0], dateStr, row[2]))

	return MyEncoder().encode(purhcases)

def purchaseStatusFactory(results):
	purchaseStatuses = []

	for row in results:	
		purchaseStatuses.append(PurchaseStatus(row[0], row[1]))

	return MyEncoder().encode(purchaseStatuses)
