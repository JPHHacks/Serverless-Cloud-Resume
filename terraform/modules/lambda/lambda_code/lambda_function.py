import boto3 # type: ignore

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('WebsiteViewCounter') 

def lambda_handler(event,context):
    response = table.get_item(Key = {'ID':'0'})
    views = response['Item']['views']
    views = views +1
    print(views)
    response = table.put_item(Item = {'ID': '0', 'views': views})
    
    return views