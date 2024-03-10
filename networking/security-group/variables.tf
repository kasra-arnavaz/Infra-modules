# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "http_port" {
  description = "The HTTP port the server listens on"
  type        = number
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "name" {
  description = "The name of the security group"
  type        = string
  default     = "allow_http_inbound"
}

variable "cidr_blocks" {
  description = "The list of allowed IPs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
