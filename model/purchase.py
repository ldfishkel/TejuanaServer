class Purchase:
	def __init__(self, purchaseId, dueDate, status):
		self.Id = purchaseId
		self.DueDate = dueDate
		self.Status = status

class PurchaseStatus:
	def __init__(self, statusId, statusName):
		self.Id = statusId
		self.Name = statusName
