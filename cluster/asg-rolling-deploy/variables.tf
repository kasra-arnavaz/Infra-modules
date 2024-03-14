# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "env_name" {
  description = "The name of the environment, e.g. dev, stage, prod"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Only free tier is allowed: t2.micro | t3.micro."
  }
}

variable "ami" {
  description = "The AMI to run in the cluster"
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  validation {
    condition     = var.min_size > 0
    error_message = "ASGs can't be empty or we'll have an outage!"
  }
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  validation {
    condition     = var.max_size <= 10
    error_message = "ASGs must have 10 or fewer instances to keep the costs down."
  }
}

variable "subnet_ids" {
  description = "The subnet IDs to deploy to"
  type        = list(string)
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name to use for the cluster resources"
  type        = string
  default     = "my-cluster"
}

variable "user_data" {
  description = "The user data script to run in each Instance at boot"
  type        = string
  default     = null
}

variable "server_port" {
  description = "The port number the server listens on"
  type        = number
  default     = 8080
}

variable "enable_scheduling" {
  description = "If true, enable autoscaling"
  type        = bool
  default     = false
}

variable "target_group_arns" {
  description = "The ARNs of ELB target groups in which to register Instances"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "The type of health check to perform."
  type        = string
  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "Must be one of: EC2 | ELB."
  }
  default = "EC2"
}
