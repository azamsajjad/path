import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    response = s3.list_buckets()
    buckets = [bucket['Name'] for bucket in response['Buckets']]
    if 'my-bucket329329' in buckets:
        print("Bucket exists")
    else: 
        s3.create_bucket(Bucket='my-bucket329329')
        print("Bucket created")
    # upload test.txt
    s3.upload_file('test.txt', 'my-bucket329329', 'test.txt')
    # create new object in the bucket
    s3.put_object(Bucket='my-bucket329329', Key='test2.txt', Body='Hello World')
    # delete an object from my-bucket329329
    s3.delete_object(Bucket='my-bucket329329', Key='test.txt')
    # enable versioning on bucket ='my-bucket329329'
    s3.put_bucket_versioning(Bucket='my-bucket329329', VersioningConfiguration={'Status': 'Enabled'})
    return "Success"