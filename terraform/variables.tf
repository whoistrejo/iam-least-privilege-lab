variable "aws_region" { type = string, default = "us-east-1" }
variable "trusted_principal_arn" {
  description = "ARN of an existing IAM role/user allowed to assume the lab role."
  type = string
}
variable "target_bucket_arn" {
  description = "ARN of the specific test bucket, without a trailing slash."
  type = string
}
