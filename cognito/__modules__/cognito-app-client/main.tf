resource "aws_cognito_user_pool_client" "user-pool-client" {
  name         = var.name != "" ? var.name : null
  user_pool_id = var.userPoolId != "" ? var.userPoolId : null

  generate_secret        = var.generate_secret != "" ? var.generate_secret : null
  refresh_token_validity = var.refresh_token_validity != "" ? var.refresh_token_validity : null
  explicit_auth_flows    = var.explicit_auth_flows != "" ? var.explicit_auth_flows : null
  read_attributes        = var.read_attributes != "" ? var.read_attributes : null
  write_attributes       = var.write_attributes != "" ? var.write_attributes : null
}