variable "name" {
  type = string
  default = ""
}

variable "auto_verified_attributes" {
  type = list(string)
  default = []
}

variable "username_attributes" {
  type = list(string)
  default = []
}

variable "mfa_configuration" {
  type = string
  default = ""
}

variable "email_configuration" {
  type = list(map(string))
}

variable "admin_create_user_config" {
  type = any
}

variable "verification_message_template" {
  type = any
}

variable "password_policy" {
  type = list(map(string))
}

variable "schema" {
  type = any
}