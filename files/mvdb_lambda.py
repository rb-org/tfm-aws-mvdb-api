import boto3
import os
import json
import decimal
from datetime import datetime
from botocore.exceptions import ClientError
from boto3.dynamodb.conditions import Key, Attr

table_name = os.environ['TABLE_NAME']
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(table_name)
client = boto3.client('dynamodb')

# Helper class to convert a DynamoDB item to JSON.


class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            if o % 1 > 0:
                return float(o)
            else:
                return int(o)
        return super(DecimalEncoder, self).default(o)


def lambda_handler(event, context):

    year = event['queryStringParameters']['year']
    title = event['queryStringParameters']['title']

    print("Table name: {0}".format(table_name))
    print("Received event: " + json.dumps(event, indent=2))
    print("#################################################")
    print("Year to find: {0}".format(year))
    print("Title to find: {0}".format(title))
    # operation = event['operation']
    operation = event['httpMethod'].lower()

    try:
        if operation == 'get':
            result = client.get_item(TableName=table_name, Key={
                'year': {'N': event['queryStringParameters']['year']},
                'title': {'S': event['queryStringParameters']['title']},
            })

    #     operations = {
    #         'put': lambda x: dynamo.put_item(**x),
    #         'post': lambda x: dynamo.put_item(**x),
    #         'get': lambda x: dynamo.get_item(**x),
    #         'update': lambda x: dynamo.update_item(**x),
    #         'delete': lambda x: dynamo.delete_item(**x),
    #         'scan': lambda x: dynamo.scan(**x),
    #         'echo': lambda x: x,
    #         'ping': lambda x: 'pong'
    #     }

        print(result)

        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(result['Item'], cls=DecimalEncoder)
        }

    except ClientError as e:
        print(e.response['Error']['Message'])
