provider "aws" {
  region = "us-east-1"  
}

data "archive_file" "lambda_function_zip" {
  type        = "zip"
  source_file = "python_file/lambda_file.py"  
  output_path = "python_file/lambda_file.zip"
}




resource "aws_lambda_function" "example_lambda" {
  function_name = "tera_cp_test2"
  runtime       = "python3.11"
  handler       = "lambda_file.lambda_handler"
  role          = "arn:aws:iam::736370134088:role/service-role/upload_files-role-hlzysb9l" 
  filename      = data.archive_file.lambda_function_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_function_zip.output_path)

  environment {
    variables = {
      bucket = "city_data12234",
      data_tes = "testing",
    }
  }
}

data "aws_s3_bucket" "existing_bucket" {
  bucket = "pravesh-city-data"  
}

resource "aws_s3_bucket_notification" "example_s3_trigger" {
  bucket = data.aws_s3_bucket.existing_bucket.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.example_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "citydata/active/" 
    filter_suffix       = ".csv"   
  }
}
