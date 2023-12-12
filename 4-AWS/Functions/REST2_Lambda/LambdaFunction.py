import json

print('loading function...')

def lambda_handler(event, context):
	# 1- parse out query string parameters
	transactionId = event['queryStringParameters']['transactionId']
	transactionType = event['queryStringParameters']['type']
	transactionAmount = event['queryStringParameters']['amount']

	print('transactionId=' + transactionId)
	print('transactionType=' + transactionType)
	print('transactionAmount=' + transactionAmount)

	# 2- Construct the body of the response object
	transactionResponse = {}
	transactionResponse['transactionId'] = transactionId
	transactionResponse['type'] = transactionType
	transactionResponse['amount'] = transactionAmount
	transactionResponse['message'] = 'Hello for REST2_Lambda'

	# 3- Construct Http Response Object
	responseObject = {}
	responseObject['statusCode'] = 200
	responseObject['headers'] = {}
	responseObject['headers']['Content-Type'] = 'application/json'
	responseObject['body'] = json.dumps(transactionResponse)

	# 4- Return the Response Object
	return responseObject