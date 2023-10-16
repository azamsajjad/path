# command to zip files addObjects.py and test.txt
# zip -r addObjects.zip addObjects.py test.txt

# aws cli command to get iam role arn for name LambdaDeploymentRole
aws iam get-role --role-name LambdaDeploymentRole --query 'Role.Arn' --output text

arn:aws:iam::240123890349:role/LambdaDeploymentRole
# aws cli comrnand to upload a lambda function addObjects.ztp file to the console with runtime 3.10
aws  lambda create-function --function-name addObjects --runtime python3.10 --role arn:aws:iam::240123890349:role/LambdaDeploymentRole --handler addObjects.lambda_handler --zip-file fileb://addObjects.zip

in cloud9
just write comment, codewisperer will suggest command