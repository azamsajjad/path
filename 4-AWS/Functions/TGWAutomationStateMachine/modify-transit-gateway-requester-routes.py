import json
import boto3

from botocore.config import Config

activeRegion="us-east-1"
passiveRegion='us-west-2'

activeConfig = Config(
    region_name = activeRegion,
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

    activeResponse = activeClient.describe_transit_gateways(
                        Filters=[
                            {
                                'Name': 'state',
                                'Values': [
                                    'available'
                                ]
                            }
                        ]
                    )
    
    print(activeResponse)

    activeTgRouteTableId=activeResponse["TransitGateways"][0]["Options"]["AssociationDefaultRouteTableId"]

    passiveDescVpcsResponse=passiveClient.describe_vpcs(
                                Filters=[
                                    {
                                        'Name': 'tag:addtotransitgateway',
                                        'Values': ['true']
                                    }
                                ]
                            )
    
    print(passiveDescVpcsResponse)

    passiveCidrs=[]

    for vpc in passiveDescVpcsResponse["Vpcs"]:

        passiveCidrs.append(vpc["CidrBlock"])

    transitGatewayAttachmentId=activeClient.describe_transit_gateway_attachments(
                                    Filters=[
                                        {
                                            'Name': 'association.transit-gateway-route-table-id',
                                            'Values': [activeTgRouteTableId]
                                        }
                                    ]
                                )["TransitGatewayAttachments"][0]["TransitGatewayAttachmentId"]
    
    print(transitGatewayAttachmentId)

    for cidr in passiveCidrs:

        searchTgRouteResponse = activeClient.search_transit_gateway_routes(
                    TransitGatewayRouteTableId=activeTgRouteTableId,
                    Filters=[
                        {
                            'Name': 'route-search.exact-match',
                            'Values': [cidr]
                        },
                        {
                            'Name': 'attachment.transit-gateway-attachment-id',
                            'Values': [transitGatewayAttachmentId]
                        }
                    ]
                )
        
        print(searchTgRouteResponse)

        if len(searchTgRouteResponse["Routes"])==0:

            createTgRouteResponse=activeClient.create_transit_gateway_route(
                DestinationCidrBlock=cidr,
                TransitGatewayRouteTableId=activeTgRouteTableId,
                TransitGatewayAttachmentId=transitGatewayAttachmentId,
                Blackhole=False,
                DryRun=False
                )
            
            print(createTgRouteResponse)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Completed run successfully')
    }