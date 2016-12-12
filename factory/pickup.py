from model.pickup import *
from components.jsonEncoder import MyEncoder

def pickUpListFactory(results):
	pickUps = []

	for row in results:	

		pickUps.append(PickUp(row[0], row[1], row[2]))

	return MyEncoder().encode(pickUps)

def pickUpStatusFactory(results):
	pickUpStatuses = []

	for row in results:	
		pickUpStatuses.append(PickUpStatus(row[0], row[1]))

	return MyEncoder().encode(pickUpStatuses)
