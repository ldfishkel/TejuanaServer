class Order:
	def __init__(self, orderId, purchaseId, clientId, clientName, prodId, prodName, prodStock, prodType, amount, dueDate):
		self.Id = orderId
		self.PurchaseId = purchaseId
		self.Client = OrderClient(clientId, clientName)
		self.Product = OrderProduct(prodId, prodName, prodStock, prodType)
		self.Amount = amount
		self.DueDate = dueDate

class OrderClient:
	def __init__(self, clientId, clientName):
		self.Id = clientId
		self.Name = clientName

class OrderProduct:
	def __init__(self, prodId, prodName, prodStock, prodType):
		self.Id = prodId
		self.Name = prodName
		self.Stock = prodStock
		self.Type = OrderProductType(prodType)

class OrderProductType:
	def __init__(self, typeName):
		self.Name = typeName
