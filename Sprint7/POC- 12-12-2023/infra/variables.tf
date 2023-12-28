variable "database_username" {
  type        = string
  description = "Username of database user"
  sensitive = true
}
variable "database_user_password" {
  type        = string
  description = "Password of of database user"
  sensitive = true
}