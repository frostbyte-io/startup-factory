resource "aws_cognito_user_pool" "pool" {
  name                     = var.name != "" ? var.name : null
  auto_verified_attributes = var.auto_verified_attributes != [] ? var.auto_verified_attributes : null
  username_attributes      = var.username_attributes != [] ? var.username_attributes : null
  mfa_configuration        = var.mfa_configuration != "" ? var.mfa_configuration : null

  dynamic "admin_create_user_config" {
    for_each = var.admin_create_user_config

    content {
      allow_admin_create_user_only = lookup(admin_create_user_config.value, "allow_admin_create_user_only", null)
      unused_account_validity_days = lookup(admin_create_user_config.value, "unused_account_validity_days", null)

      dynamic "invite_message_template" {
        for_each = admin_create_user_config.value.invite_message_template

        content {
          email_subject = lookup(invite_message_template.value, "email_subject", null)
          email_message = fileexists(lookup(invite_message_template.value, "email_message", "")) ? templatefile(invite_message_template.value.email_message, lookup(invite_message_template.value, "email_message_tpl_params", {})) : null
          sms_message   = fileexists(lookup(invite_message_template.value, "sms_message", "")) ? templatefile(invite_message_template.value.email_message, lookup(invite_message_template.value, "sms_message_tpl_params", {})) : null
        }
      }
    }
  }

  dynamic "email_configuration" {
    for_each = var.email_configuration

    content {
      source_arn             = lookup(email_configuration.value, "source_arn", null)
      email_sending_account  = lookup(email_configuration.value, "email_sending_account", null)
      reply_to_email_address = lookup(email_configuration.value, "reply_to_email_address", null)
    }
  }

  dynamic "verification_message_template" {
    for_each = var.verification_message_template

    content {
      default_email_option = lookup(verification_message_template.value, "default_email_option", null)
      email_subject        = lookup(verification_message_template.value, "email_subject", null)
      email_message        = fileexists(lookup(verification_message_template.value, "email_message", "")) ? templatefile(verification_message_template.value.email_message, lookup(verification_message_template.value, "email_message_tpl_params", {})) : null
    }
  }

  dynamic "password_policy" {
    for_each = var.password_policy

    content {
      minimum_length    = lookup(password_policy.value, "minimum_length", null)
      require_lowercase = lookup(password_policy.value, "require_lowercase", null)
      require_numbers   = lookup(password_policy.value, "require_numbers", null)
      require_symbols   = lookup(password_policy.value, "require_symbols", null)
      require_uppercase = lookup(password_policy.value, "require_uppercase", null)
    }
  }

  dynamic "schema" {
    for_each = var.schema

    content {
      attribute_data_type = schema.value.attribute_data_type
      name                = schema.value.name
      mutable             = lookup(schema.value, "mutable", null)
      required            = lookup(schema.value, "required", null)

      dynamic "string_attribute_constraints" {
        for_each = schema.value.string_attribute_constraints

        content {
          min_length = lookup(string_attribute_constraints.value, "min_length", null)
          max_length = lookup(string_attribute_constraints.value, "max_length", null)
        }
      }
    }
  }
}
