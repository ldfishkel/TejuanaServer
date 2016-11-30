class Product:
	def __init__(self, id, name, prodType, imageURL, tejuarAvgTime, price, size, stock):
	    self.Id = id
	    self.Name = name
	    self.Supplies = []
	    self.Type = prodType
	    self.ImageURL = imageURL
	    self.AvgProductionTime = tejuarAvgTime
	    self.Price = float(price)
	    self.Size = size
	    self.Stock = stock

class ProductType:
	def __init__(self, id, name):
	    self.Id = id
	    self.Name = name

class Supply:
	def __init__(self, id, name, quantity):
	    self.Id = id
	    self.Name = name
	    self.Amount = quantity
