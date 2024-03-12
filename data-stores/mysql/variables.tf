# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "db_username" {
  description = "Username of the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password of the database"
  type        = string
  sensitive   = true
}
