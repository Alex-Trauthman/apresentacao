#-#-# API-GATEWAY #-#-#

variable "name_api" {
  description = "This name of api gateway"
  type        = string
  default     = "api-gateway"
}

variable "http_method" {
  description = "Method HTTP"
  type        = string
  default     = "POST"
}

#-#-# DYNAMODB #-#-#

variable "dynamodb_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "tcc-database"
}

variable "hash_key" {
  description = "The attribute to serve as the hash (partition) key. It must also be defined as an attribute."
  type        = string
  default     = "usuario"
}

variable "hash_type" {
  description = "Attribute that specifies the data type of the (hash_key) field."
  default     = "S"
  type        = string
}

variable "billing_mode" {
  description = "Controls how you are billed for read and write throughput and how you manage capacity. The valid values are PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "autoscaling_enabled" {
  description = "Whether or not to enable autoscaling. See note in README about this setting"
  type        = bool
  default     = false
}

#-#-# LAMBDA #-#-#

variable "lambda_name" {
  type        = string
  description = "Name of the Lambda Function."
  default     = "lambda-tcc"
}

variable "runtime" {
  type        = string
  description = "Engine used to execute script in Lambda."
  default     = "python3.12"
}

variable "filename" {
  type        = string
  description = "Filename of the lambda script."
  default     = "../app/LambdaFunctionOverHttps.zip"
}

variable "handler" {
  type        = string
  description = "File that will execute the Lambda."
  default     = "LambdaFunctionOverHttps.lambda_handler"
}

variable "hash" {
  type        = string
  description = "Filename of the lambda script."
  default     = null
}

variable "memory_size" {
  type        = number
  description = "Memory Size allocated to use with CPU."
  default     = 128
}

variable "reserved_concurrent_executions" {
  type        = string
  description = "Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
  default     = "-1"
}

variable "timeout" {
  type        = number
  description = "Timeout of function execution"
  default     = 3
}

variable "assume_role_policy" {
  description = "Default assume role policy of the iam role."
  default     = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
JSON
}