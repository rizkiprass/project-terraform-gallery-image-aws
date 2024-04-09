output "alb_security_group_id" {
  value = aws_security_group.alb-sg.id
}

output "app_security_group_id" {
  value = aws_security_group.app-sg.id
}

output "db_security_group_id" {
  value = aws_security_group.db-sg.id
}