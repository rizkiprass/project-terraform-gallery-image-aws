################ Role #################

#Create ssm role
resource "aws_iam_role" "ssm-core-role" {
  name               = "ssm-instance-core-role"
  assume_role_policy = file("/modules/ec2/template/assumepolicy.json")
  tags = {
    Name = "ssm-instance-core-role"
  }
}

#Attach Policy SSMCore
resource "aws_iam_role_policy_attachment" "ssmcore-attach-ssmcore" {
  role       = aws_iam_role.ssm-core-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Attach Policy CloudWatch
resource "aws_iam_role_policy_attachment" "ssmcore-attach-cwatch" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ssm-core-role.name
}

#Instance Profile
resource "aws_iam_instance_profile" "ssm-profile" {
  name = "ssm-profile"
  role = aws_iam_role.ssm-core-role.name
}