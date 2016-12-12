class SupplyData:
	def __init__(self, id, name, stock, stockReal, lastTime):
	    self.Id = id
	    self.Name = name
	    self.Stock = stock
	    self.RealStock = stockReal
	    self.LastTimeSupplied = lastTime

class Supply:
	def __init__(self, id, name):
	    self.Id = id
	    self.Name = name
