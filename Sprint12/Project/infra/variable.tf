variable "database_username" {
  description = "Username for database"
  sensitive = true
  type = string
}
variable "database_user_password" {
    description = "Password of user accessing database"
    sensitive = true
    type = string
}