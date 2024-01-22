import boto3

def lambda_handler(event, context):
    # Replace 'source_bucket' and 'source_key' with the source S3 bucket and key
    #s3://pravesh-city-data/citydata/active/
    source_bucket = 'pravesh-city-data'
    source_key = 'citydata/active/CityData.csv'

    # s3://pravesh-city-data/active/CityData.csv to s3://pravesh-city-data/Unsaved/
    #s3://pravesh-city-data/Unsaved/
    destination_bucket = 'pravesh-city-data'
    destination_key = 'Unsaved/CityData.csv'
    print(f" from s3://{source_bucket}/{source_key} to s3://{destination_bucket}/{destination_key}")
    # Create an S3 client
    s3 = boto3.client('s3')

    try:
        # Copy the file from the source to the destination
        s3.copy_object(
            Bucket=destination_bucket,
            CopySource={'Bucket': source_bucket, 'Key': source_key},
            Key=destination_key
        )

        print(f"File copied from s3://{source_bucket}/{source_key} to s3://{destination_bucket}/{destination_key}")

        return {
            'statusCode': 200,
            'body': 'File copy successful'
        }

    except Exception as e:
        print(f"Error copying file: {e}")
        return {
            'statusCode': 500,
            'body': 'Error copying file'
        }
