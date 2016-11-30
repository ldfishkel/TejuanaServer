import web
from logger.logger import logErrorMsg

class RestError(web.HTTPError):
	def __init__(self, statusCode, message):
		logErrorMsg(message)
		status = statusCode
		headers = {'Content-Type': 'text/html'}
		data = "<h1>" + message + "</h1>"
		web.HTTPError.__init__(self, status, headers, data)

class BadRequest(RestError):
	def __init__(self, msg):
		RestError.__init__(self, '400', msg)

