terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  profile = var.profile
  region  = var.aws_region
}

module "cognito_user_pool" {
  source                        = "../__modules__/cognito-user-pool"
  
  name                          = var.cognito_user_pool.name
  auto_verified_attributes      = var.cognito_user_pool.auto_verified_attributes
  username_attributes           = var.cognito_user_pool.username_attributes
  mfa_configuration             = var.cognito_user_pool.mfa_configuration
  email_configuration           = var.cognito_user_pool.email_configuration
  admin_create_user_config      = var.cognito_user_pool.admin_create_user_config
  verification_message_template = var.cognito_user_pool.verification_message_template
  password_policy               = var.cognito_user_pool.password_policy
  schema                        = var.cognito_user_pool.schema
}

module "cognito-app-client" {
  source                 = "../__modules__/cognito-app-client"

  userPoolId             = module.cognito_user_pool.id
  name                   = var.cognito_app_client.name
  generate_secret        = var.cognito_app_client.generate_secret
  refresh_token_validity = var.cognito_app_client.refresh_token_validity
  explicit_auth_flows    = var.cognito_app_client.explicit_auth_flows
  read_attributes        = var.cognito_app_client.read_attributes
  write_attributes       = var.cognito_app_client.write_attributes
}
