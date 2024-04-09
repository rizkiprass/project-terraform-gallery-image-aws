output "ssm_core_role_arn" {
  description = "ARN of the SSM Core IAM Role"
  value       = aws_iam_role.ssm-core-role.arn
}

output "ssm_core_role_name" {
  description = "Name of the SSM Core IAM Role"
  value       = aws_iam_role.ssm-core-role.name
}

output "ssm_core_instance_profile_arn" {
  description = "ARN of the SSM Core Instance Profile"
  value       = aws_iam_instance_profile.ssm-profile.arn
}

output "ssm_core_instance_profile_name" {
  description = "Name of the SSM Core Instance Profile"
  value       = aws_iam_instance_profile.ssm-profile.name
}
