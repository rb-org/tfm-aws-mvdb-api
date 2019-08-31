import boto3
import os
import json
from datetime import datetime


def lambda_handler(event, context):
    if 'TableName' not in event:
        raise Exception("No table name specified.")
    table_name = event['TableName']

    print(table_name)

    print("Received event: " + json.dumps(event, indent=2))

    dynamo = boto3.resource('dynamodb').Table(event['TableName'])

    operation = event['operation']

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
