import json
import boto3
import uuid

client = boto3.client('stepfunctions')

def lambda_handler(event, context):
	# AUTO-GENERATE INPUT -> { "TransactionId": "uuid", "Type": "Purchase"}
	transactionId = str(uuid.uuid1()) # e.g.343jj3-34df4-vfg454-334gd5

	input = {'TransactionId': transactionId, 'Type': 'PURCHASE'}

	response = client.start_execution(
		stateMachineArn='arn:aws:states:us-east-1:767665886117:stateMachine:TransactionProcessingStateMachineFromSQSStartbyLambda',
		name=transactionId,
		input=json.dumps(input)
		)