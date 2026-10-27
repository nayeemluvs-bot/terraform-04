data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["ecs-vpc"]
  }
}

output "account_id" {
  value       = "data.aws_region.current.name"
  description = "Region resolved by the AWS provider"
}

output "selected_vpc_id" {
  value = data.aws_vpc.selected.id
}