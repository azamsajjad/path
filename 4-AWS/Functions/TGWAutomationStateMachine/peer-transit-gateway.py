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
  activeTransitGatewayId=activeResponse["TransitGateways"][0]["TransitGatewayId"] 
  activeOwnerId=activeResponse["TransitGateways"][0]["OwnerId"]
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
  passiveTransitGatewayId=passiveResponse["TransitGateways"][0]["TransitGatewayId"]
  passiveOwnerId=passiveResponse["TransitGateways"][0]["OwnerId"]
  
  descTgwAttachResponse = activeClient.describe_transit_gateway_attachments(
              Filters=[
                  {
                      'Name': 'transit-gateway-id',
                      'Values': [activeResponse["TransitGateways"][0]["TransitGatewayId"]
                      ]
                  },
                  { 
                      'Name': 'resource-type',
                      'Values': ['peering'] 
                  },
                  {
                      'Name': 'state',
                      'Values': ["available", "initiatingRequest",  "modifying", "pendingAcceptance", "pending", "rejected",  "rejecting"]
                                   }
              ]
          )
  print(descTgwAttachResponse)
  if len(descTgwAttachResponse["TransitGatewayAttachments"]) ==0:
      createTGAResponse=activeClient.create_transit_gateway_peering_attachment(TransitGatewayId=activeTransitGatewayId,
              PeerTransitGatewayId=passiveTransitGatewayId,
              PeerAccountId=passiveOwnerId,
              PeerRegion=passiveRegion,
              TagSpecifications=[
                  {
                      'ResourceType': 'transit-gateway-attachment',
                      'Tags': [
                          {
                              'Key': 'PeerTransitGatewayId',
                              'Value': passiveTransitGatewayId
                          },
                          {
                              'Key': 'TransitGatewayId',
                              'Value': activeTransitGatewayId
                          }
                      ]
                  }
              ])
      print(createTGAResponse)  
      transitGatewayAttachmentId=createTGAResponse["TransitGatewayPeeringAttachment"]["TransitGatewayAttachmentId"]
      time.sleep(60)
      acceptTGAResponse=passiveClient.accept_transit_gateway_peering_attachment(TransitGatewayAttachmentId=transitGatewayAttachmentId)
      print(acceptTGAResponse)
  return {
      'statusCode': 200,
      'body': json.dumps('Completed run successfully')
  }