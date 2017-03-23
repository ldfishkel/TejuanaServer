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

def clientListFactory(results, addresses):
	clients = []

	for row in results:

		clients.append(Client(row[0], row[1], row[2], row[3]))

	return MyEncoder().encode(map(lambda x : addAddresses(x, addresses), clients))

def addAddresses(client, addresses):
	for address in addresses:
		
		if address[7] == client.Id:
			
			addr = Address(address[0], address[1], address[2], address[3], address[4], address[5])
			client.Addresses.append(addr)
			
			if address[6]:
				client.DefaultAddress = addr

	return client