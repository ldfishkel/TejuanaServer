import web
from logger.logger import logErrorMsg

class RestError(web.HTTPError):
	def __init__(self, statusCode, message):
		logErrorMsg(message)
		status = statusCode
		headers = {'Content-Type': 'text/html'}
		data = message
		web.HTTPError.__init__(self, status, headers, data)

class BadRequest(RestError):
	def __init__(self, msg):
		RestError.__init__(self, '400', msg)

class UnAuthorized(RestError):
	def __init__(self, msg):
		RestError.__init__(self, '401', msg)

class Forbidden(RestError):
	def __init__(self, msg):
		RestError.__init__(self, '403', msg)
		
class InternalServerError(RestError):
	def __init__(self, msg):
		RestError.__init__(self, '500', msg)

