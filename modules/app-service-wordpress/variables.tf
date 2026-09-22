variable "prefix" {
  description = "Name prefix for all resources."
  type        = string
}

variable "location" {
  description = "Locally region name (e.g. berlin)."
  type        = string
  default     = "berlin"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources in this example."
  type        = map(string)
}

variable "mysql_admin_login" {
  description = "MySQL administrator login. Must satisfy Azure MySQL rules (1-32 chars, letter-led, [A-Za-z0-9_], not a reserved name)."
  type        = string
  default     = "wpadmin"
}

variable "mysql_admin_password" {
  description = "MySQL administrator password. Must satisfy Azure MySQL complexity (8-128 chars, >=3 of upper/lower/digit/special, must not contain the login)."
  type        = string
  sensitive   = true
}
