variable "profile" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "cognito_user_pool" {
  type = any
}

variable "cognito_app_client" {
  type = any
}