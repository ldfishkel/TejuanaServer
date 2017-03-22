import web
import json
from logger.logger import *
from data.dataAccess import *
from data.security import *
from data.purchase import *
from factory.purchase import *

class Purchase:
	def GET(self, statusId):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("CALL Tejuana.PurchaseList({0})".format(statusId))
			return purchaseListFactory(results)

	def POST(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			data = web.data()
			logPayload(data)
			purchase = json.loads(data)
			insertPurchase(purchase)

class PurchaseStatus:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("SELECT * FROM Tejuana.Purchase_Status")
			return purchaseStatusFactory(results)


class Client:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			search = web.ctx.env.get('QUERY_STRING').split('=')[1]
			results = query("CALL Tejuana.ClientsBy('{0}')".format(search))
			addresses = query("CALL Tejuana.AddressesBy('{0}')".format(search))
			return clientListFactory(results, addresses)

	def PUT(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			data = web.data()
			logPayload(data)
			client = json.loads(data)
			updateClient(client)

