"""
This is an example of a program for your first day at Coders Campus.
It starts by defining a message (msg) and a file name (filename), then generates a banner with the message, prints the banner and saves it the file in the local directory.
The program defines a bucket (bucket_name) and uploads the file generated in the filesystem location to that bucket on Amazon S3.
"""

import pyfiglet
import os
import logging
import boto3
from botocore.exceptions import ClientError


def upload_file(file_name, bucket, object_name=None):
    """
    Upload a file to an S3 bucket

    :param file_name: File to upload
    :param bucket: Bucket to upload to
    :param object_name: S3 object name. If not specified then file_name is used
    :return: True if file was uploaded, else False
    """
    
    # If S3 object_name was not specified, use file_name
    if object_name is None:
        object_name = os.path.basename(file_name)

    # Upload the file
    s3_client = boto3.client('s3')
    try:
        response = s3_client.upload_file(file_name, bucket, object_name)
    except ClientError as e:
        logging.error(e)
        return False
    
       
    # YOUR CODE HERE
    # Reference: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-uploading-files.html
    
    return False
    

def save_file(content, filename):
    """
    Saves file in the local filesystem
    
    :param content: the content to be saved inside the file
    :param filename: the name of the file in the local filesystem
    """
    f = open(filename, 'w')
    f.write(content)
    f.close()

def generate_banner(msg):
    """"
    Generates a banner from the message
    
    :param msg: message to be formatted as a banner
    :return: the message formatted as a banner
    """
    ascii_banner = pyfiglet.figlet_format(msg)
    return ascii_banner


def main():
    """"
    The main entry point when the python is executed
    """
    msg = "Hello World!"
    filename = "hello.txt"
    
    # Generates a banner from the msg
    banner = generate_banner(msg)
    
    # Prints the banner in the screen
    print(banner)
    
    # Saves the content of the banner in a file in local filesystem with the filename
    save_file(banner, filename)
    
    # Replace YOUR_BUCKET_NAME with the bucket name you created
    bucket_name = 'lab-ada-329329'
    
    # Uploads the filename into S3 Bucket name
    if upload_file(filename,bucket_name): 
      print("Upload successful")
    else:
      print("Upload Not Implemented yet")


if __name__ == "__main__":
    main()