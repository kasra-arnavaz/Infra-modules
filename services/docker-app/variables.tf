# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "env_name" {
  description = "The name of the environment, e.g. dev, stage, prod"
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

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "The name of this docker application"
  type        = string
  default     = "my-docker-app"
}

variable "cluster_name" {
  description = "The name to use for the cluster resources"
  type        = string
  default     = "my-cluster"
}

variable "alb_name" {
  description = "The name to use for the Application Load Balancer"
  type        = string
  default     = "my-alb"
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
  default     = null
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
  default     = null
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "Only free tier is allowed: t2.micro | t3.micro."
  }
}

variable "enable_scheduling" {
  description = "Whether to vary the number of Instances based on time"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy into"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "The IDs of the subnets to deploy into"
  type        = list(string)
  default     = null
}

variable "db_config" {
  description = "The address,port, and name of the database"
  type = object({
    address  = string
    port     = number
    name     = string
    table    = string
    username = string
    password = string
  })
  default = null
}
