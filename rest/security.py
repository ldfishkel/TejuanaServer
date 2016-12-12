import web
import json
from logger.logger import *
from components.jwtEncoder import *
from rest.httpError import UnAuthorized
from data.security import *

class Token:
	def POST(self):
		data = web.data()
		logPayload(data)
		payload = json.loads(data)
		if isAdminPassword(payload["Password"]):
			return json.dumps(encode(AdminPayload()))
		else:
			raise UnAuthorized("Password incorrecta")