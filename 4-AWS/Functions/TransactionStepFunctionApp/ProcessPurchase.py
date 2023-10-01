from __future__ import print_function

import json
import urllib
import boto3
import datetime

print('Loading function....')

def process_purchase(message, context):

	# Input Example
	# { "TransactionType": "PURCHASE"}

	# 1- Log Input Message
	print("Received Message from Step Functions:")
	print(message)

	# 2- Construct Response Object
	response = {}
	response['TransactionType'] = message['TransactionType']
	response['Timestamp'] = datetime.datetime.now().strftime("%Y-%m-%d %H-%M-%S")
	response['Message'] = 'Hello from Lambda Land inside the ProcessPurchase Function'

	return response