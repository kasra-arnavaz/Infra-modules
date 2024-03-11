# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "inbound_port" {
  description = "The port the server listens on"
  type        = number
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------


variable "cidr_blocks" {
  description = "The list of allowed IPs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
