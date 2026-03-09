variable "region" {
  type        = string
  description = "The region where resources will be created"
  default     = "cn-hangzhou"
}

variable "name_prefix" {
  type        = string
  description = "The name prefix for all resources"
  default     = "tf-example-edas"
}