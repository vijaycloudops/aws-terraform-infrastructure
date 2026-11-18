output "vpc_id" {
  description = "ID of the provisioned VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "instance_id" {
  description = "EC2 instance ID. Connect using Systems Manager Session Manager."
  value       = aws_instance.demo.id
}

output "instance_public_ip" {
  description = "Public IP address. No inbound ports are open in the security group."
  value       = aws_instance.demo.public_ip
}

output "website_url" {
  description = "HTTP URL for the Nginx demo page. Add a temporary HTTP ingress rule only if you intentionally want public web access."
  value       = "http://${aws_instance.demo.public_ip}"
}

output "aws_region" {
  description = "AWS region used for this deployment."
  value       = var.aws_region
}
