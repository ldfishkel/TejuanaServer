import web
from data.dataAccess import *
from data.security import *
from data.order import *
from factory.order import *

class Order:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("CALL Tejuana.OrderList()")
			return orderListFactory(results)

	def PUT(self, orderId):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			orderReady(orderId)

class Orderr:
	def GET(self):
		2/0
		return "HOLA"