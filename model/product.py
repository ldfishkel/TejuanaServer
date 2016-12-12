class Product:
	def __init__(self, id, name, prodType, tejuarAvgTime, price, size, stock):
	    self.Id = id
	    self.Name = name
	    self.Supplies = []
	    self.Type = prodType
	    self.Images = []
	    self.AvgProductionTime = tejuarAvgTime
	    self.Price = float(price)
	    self.Size = size
	    self.Stock = stock

class ProductType:
	def __init__(self, id, name):
	    self.Id = id
	    self.Name = name

class ProductSupply:
	def __init__(self, id, name, quantity):
	    self.Id = id
	    self.Name = name
	    self.Amount = quantity

class Tag:
	def __init__(self, id, name):
	    self.Id = id
	    self.Name = name
