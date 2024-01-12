import json
import logging
import boto3

# Create a CloudWatch Logs client
cloudwatch = boto3.client('logs')

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        word = ''
        query_params = event['queryStringParameters']
        if query_params is not None:
            word = query_params.get('word')
        
        reverse = lambda w: w[::-1]  # Define the lambda function to reverse the word
        reversed_word = reverse(word)
        
        # Log the reversed word
        logger.info(f'Reversed word: {reversed_word}')

        return {
            'statusCode': 200,
            'body': json.dumps(reversed_word)
        }
    except Exception as e:
        # Log any exceptions
        logger.exception("An exception occurred")

        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }
