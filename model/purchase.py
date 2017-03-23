class Purchase:
	def __init__(self, purchaseId, dueDate, status):
		self.Id = purchaseId
		self.DueDate = dueDate
		self.Status = status

class PurchaseStatus:
	def __init__(self, statusId, statusName):
		self.Id = statusId
		self.Name = statusName

class Client:
	def __init__(self, clientId, clientName, clientEmail, clientPhone):
		self.Id = clientId
		self.Name = clientName
		self.Email = clientEmail
		self.Phone = clientPhone
		self.DefaultAddress = ''
		self.Addresses = []

class Address:
	def __init__(self, addressId, address, zipcode, province, region, district):
		self.Id = addressId
		self.Address = address
		self.ZipCode = zipcode
		self.Province = province
		self.Region = region
		self.District = district
