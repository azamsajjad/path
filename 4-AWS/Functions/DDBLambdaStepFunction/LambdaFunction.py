import json

def lambda_handler(event, context):
    # TODO implement
    print(event)
    raise Exception
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


IN LAMBDA CATCHER - DONT FORGET TO SPECIFY RESULT PATH

ResultPath - optional
Use the ResultPath filter to add the error to the original state input before sending it as output to the fallback state.

$.result 

it will act as input to DynamoDB DELETEITEM