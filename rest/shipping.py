import web
from data.dataAccess import *
from data.security import *
from factory.shipping import *

class Shipping:
	def GET(self, statusId):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("CALL Tejuana.ShippingList({0})".format(statusId))
			return shippingListFactory(results)

class ShippingStatus:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("SELECT * FROM Tejuana.Shipping_Status")
			return shippingStatusFactory(results)

