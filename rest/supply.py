import web
import json
from logger.logger import *
from data.supply import *
from data.security import *
from data.dataAccess import *
from factory.supply import *

class SupplyData:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("select * from Tejuana.SupplyDataList")
			return supplyDataListFactory(results)

class Supply:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("select * from Tejuana.ProductSuppliesList")
			return supplyListFactory(results)

	def POST(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			data = web.data()
			logPayload(data)
			supply = json.loads(data)
			insertSupply(supply)

class SupplyMov:
	def POST(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			data = web.data()
			logPayload(data)
			supplyMov = json.loads(data)
			insertSupplyMov(supplyMov)