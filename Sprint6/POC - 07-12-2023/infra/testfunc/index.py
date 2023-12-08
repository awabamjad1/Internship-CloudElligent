import json

def lambda_handler(event, context):
    try:
        word = ''
        query_params = event['queryStringParameters']
        if query_params is not None:
            word = query_params.get('word')
        
        reverse = lambda w: w[::-1]  # Define the lambda function to reverse the word
        reversed_word = reverse(word)
        
        return {
            'statusCode': 200,
            'body': json.dumps(reversed_word)
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }
