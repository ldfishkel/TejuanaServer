import web
from data.dataAccess import *
from data.security import *
from factory.purchase import *

class Purchase:
	def GET(self, statusId):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("CALL Tejuana.PurchaseList({0})".format(statusId))
			return purchaseListFactory(results)

class PurchaseStatus:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("SELECT * FROM Tejuana.Purchase_Status")
			return purchaseStatusFactory(results)

