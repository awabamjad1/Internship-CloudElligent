import boto3
import json
from decimal import Decimal

def lambda_handler(event, context):
    http_method = event.get('httpMethod')
    if http_method == 'GET':
        dynamodb = boto3.resource('dynamodb')
        table_name = 'students'
        table = dynamodb.Table(table_name)
        
        try:
            response = table.scan()
            items = response['Items']
            
            while 'LastEvaluatedKey' in response:
                response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
                items.extend(response['Items'])
            
            def decimal_default(obj):
                if isinstance(obj, Decimal):
                    return float(obj)
                raise TypeError
            
            return {
                'statusCode': 200,
                'headers': {
                    'Content-Type': 'application/json'
                },
                'body': json.dumps(items, default=decimal_default)
            }
        except Exception as e:
            return {
                'statusCode': 500,
                'body': json.dumps(str(e))
            }
    elif http_method == 'POST':
        try:
            dynamodb = boto3.resource('dynamodb')
            table_name = 'students'
            table = dynamodb.Table(table_name)
            
            data = json.loads(event['body'])
            
            response = table.put_item(Item=data)
            
            return {
                'statusCode': 200,
                'headers': {
                    'Content-Type': 'application/json'
                },
                'body': json.dumps('Data inserted successfully')
            }
        except Exception as e:
            return {
                'statusCode': 500,
                'body': json.dumps(str(e))
            }
    else:
        return {
            'statusCode': 405,
            'body': json.dumps('Method not allowed')
        }
