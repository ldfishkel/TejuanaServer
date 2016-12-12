class Shippng:
	def __init__(self, shippingId, address, purchaseId, status):
		self.Id = shippingId
		self.Address = address
		self.PurchaseId = purchaseId
		self.Status = status

class ShippingStatus:
	def __init__(self, statusId, statusName):
		self.Id = statusId
		self.Name = statusName
