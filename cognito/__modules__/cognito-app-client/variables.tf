variable "name" {
  type = string
}

variable "userPoolId" {
  type = string
}

variable "generate_secret" {
  type = bool
}

variable "refresh_token_validity" {
  type = number
}

variable "explicit_auth_flows" {
  type = list(string)
}

variable "read_attributes" {
  type = list(string)
}

variable "write_attributes" {
  type = list(string)
}
