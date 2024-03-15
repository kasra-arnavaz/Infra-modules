# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "env_name" {
  description = "The name of the environment, e.g. dev, stage, prod"
  type        = string
}

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

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name to use for the database"
  type        = string
  default     = "my-db"
}

variable "table" {
  description = "The name of the table to create in the database"
  type        = string
  default     = "my-table"
}
