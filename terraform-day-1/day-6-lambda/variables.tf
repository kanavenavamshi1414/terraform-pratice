variable "lambda_role_name" {
  description = "IAM role name for Lambda"
  type        = string
  default     = "lambda-execution-role"
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "python-function"
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.12"
}

variable "lambda_handler" {
  description = "Lambda handler"
  type        = string
  default     = "python.py.lambda_handler"
}

variable "s3_bucket_name" {
  description = "S3 bucket containing Lambda ZIP file"
  type        = string
  default     = "terraform-lambda-creation"
}

variable "s3_key" {
  description = "S3 key for Lambda ZIP file"
  type        = string
  default     = "python.py.zip"
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 300
}

variable "lambda_memory_size" {
  description = "Lambda memory size in MB"
  type        = number
  default     = 128
}

variable "s3_object_version" {
  description = "Version ID of the Lambda ZIP file"
  type        = string
}