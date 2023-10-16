import json
import boto3
import time

from botocore.config import Config

activeRegion='us-east-1'
passiveRegion='us-west-2'

activeConfig = Config(
  region_name =activeRegion ,
  signature_version = 'v4',
  retries = {
      'max_attempts': 1,
      'mode': 'standard'
  }
)

passiveConfig = Config(
  region_name = passiveRegion,
  signature_version = 'v4',
  retries = {
      'max_attempts': 1,
      'mode': 'standard'
  }
)

activeClient = boto3.client('ec2', config=activeConfig)
passiveClient = boto3.client('ec2', config=passiveConfig)
def lambda_handler(event, context):
  activeResponse = activeClient.describe_transit_gateways(Filters=[
                      {
                          'Name': 'state',
                          'Values': [
                              'available',
                          ]
                      }
                  ]
              )
  print(activeResponse)
  passiveResponse = passiveClient.describe_transit_gateways(Filters=[
                      {
                          'Name': 'state',
                          'Values': [
                              'available',
                          ]
                      }
                  ]
              )
  print(passiveResponse)
  descTgwAttachResponse = activeClient.describe_transit_gateway_attachments(
              Filters=[
                  {
                      'Name': 'transit-gateway-id',
                      'Values': [activeResponse["TransitGateways"][0]["TransitGatewayId"]
                      ]
                  }
              ]
          )
  print(descTgwAttachResponse)
  status=descTgwAttachResponse["TransitGatewayAttachments"][0]["State"]
  
  return {
      'status': status
  }