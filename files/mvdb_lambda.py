import boto3
import os
import json
from datetime import datetime
from botocore.exceptions import ClientError

table_name = os.environ['TABLE_NAME']
dynamo = boto3.resource('dynamodb').Table(table_name)


def lambda_handler(event, context):
    print("Table name: {0}".format(table_name))
    print("Received event: " + json.dumps(event, indent=2))

    operation = event['operation']
    try:
        operations = {
            'put': lambda x: dynamo.put_item(**x),
            'get': lambda x: dynamo.get_item(**x),
            'update': lambda x: dynamo.update_item(**x),
            'delete': lambda x: dynamo.delete_item(**x),
            'scan': lambda x: dynamo.scan(**x),
            'echo': lambda x: x,
            'ping': lambda x: 'pong'
        }

        if operation in operations:
            return operations[operation](event.get('payload'))
        else:
            raise ValueError('Unrecognized operation "{}"'.format(operation))

    except ClientError as e:
        print(e.response['Error']['Message'])

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": ""
    }
