from datetime import datetime
from components.jwtEncoder import *
from rest.httpError import *

def authAdmin(token):
	try:
		decoded = decode(token)
	except:
		raise UnAuthorized("Forbidden")

	if decoded['Role'] is None:
		raise Forbidden("Forbidden")

	if decoded['Role'] == 'admin':
		if decoded['Datetime'] is None:
			raise Forbidden("Forbidden")

		return isStillValid(decoded['Datetime']) 
	else:
		UnAuthorized("Unauthorized")

def isAdminPassword(hashedPassword):
	doubleHashedPassword = hashedPassword
	return doubleHashedPassword == 'E10ADC3949BA59ABBE56E057F20F883E'

def isStillValid(datetimeStr):
	datetimeObj = datetime.strptime(datetimeStr, "%Y-%m-%d %H:%M:%S")

	now = datetime.now()

	if (datetimeObj.year == now.year) and (datetimeObj.month == now.month) and (datetimeObj.day == now.day):
		if (datetimeObj.hour == now.hour) or ((datetimeObj.hour + 1 == now.hour) and (datetimeObj.minute < now.minute)):
			return True
	
	raise UnAuthorized("Session Expired")

