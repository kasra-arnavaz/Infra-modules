# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "env_name" {
  description = "The name of the environment, e.g. dev, stage, prod"
  type        = string
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

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  default     = null
}

variable "table" {
  description = "The name of the table to create in the database"
  type        = string
  default     = "my-table"
}

variable "backup_retention_period" {
  description = "Days to retain backups. Must be > 0 to enable replication."
  type        = number
  default     = null
}

variable "replicate_source_db" {
  description = "If specified, replicate the RDS database at the given ARN."
  type        = string
  default     = null
}

variable "db_username" {
  description = "Username of the database"
  type        = string
  sensitive   = true
  default     = null
}

variable "db_password" {
  description = "Password of the database"
  type        = string
  sensitive   = true
  default     = null
}
