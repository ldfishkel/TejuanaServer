class PickUp:
	def __init__(self, pickUpId, purchaseId, status):
		self.Id = pickUpId
		self.PurchaseId = purchaseId
		self.Status = status

class PickUpStatus:
	def __init__(self, statusId, statusName):
		self.Id = statusId
		self.Name = statusName
