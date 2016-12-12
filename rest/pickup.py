import web
from data.dataAccess import *
from data.security import *
from factory.pickup import *

class PickUp:
	def GET(self, statusId):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("CALL Tejuana.PickUpList({0})".format(statusId))
			return pickUpListFactory(results)

class PickUpStatus:
	def GET(self):
		if authAdmin(web.ctx.env.get('HTTP_AUTHORIZATION')):
			results = query("SELECT * FROM Tejuana.Pick_Up_Status")
			return pickUpStatusFactory(results)

