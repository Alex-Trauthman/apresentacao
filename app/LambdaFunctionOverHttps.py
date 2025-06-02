import boto3
import os

# Define the DynamoDB table that Lambda will connect to
table_name = os.environ['DYNAMODB_TABLE']

# Create the DynamoDB resource
dynamo = boto3.resource('dynamodb').Table(table_name)

# Define some functions to perform the CRUD operations
def create(payload):
    return dynamo.put_item(Item=payload['Item'])

def read(payload):
    return dynamo.get_item(Key=payload['Key'])

def update(payload):
    return dynamo.update_item(**{k: payload[k] for k in ['Key', 'UpdateExpression', 
    'ExpressionAttributeNames', 'ExpressionAttributeValues'] if k in payload})


def delete(payload):
    return dynamo.delete_item(Key=payload['Key'])
def scan(payload):
    # Realiza um scan na tabela, retornando todos os itens
    response = dynamo.scan()
    return response['Items']

operations = {
    'create': create,
    'read': read,
    'update': update,
    'delete': delete,
    'scan': scan
}

def lambda_handler(event, context):
    '''Provide an event that contains the following keys:
      - operation: one of the operations in the operations dict below
      - payload: a JSON object containing parameters to pass to the 
        operation being performed
    '''
    
    operation = event['operation']
    payload = event['payload']
    
    if operation in operations:
        return operations[operation](payload)
        
    else:
        raise ValueError(f'Unrecognized operation "{operation}"')