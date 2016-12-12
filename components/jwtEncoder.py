import jwt
from datetime import datetime

def encode(payload):
	return jwt.encode(payload.__dict__, 'secret', algorithm = 'HS256')

def decode(encoded):
	return jwt.decode(encoded, 'secret', algorithms = ['HS256'])

class Payload:
	def __init__(self, role):
		self.Role = role

class AdminPayload(Payload):
	def __init__(self):
		self.Datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
		Payload.__init__(self, 'admin')