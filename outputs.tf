output "repository_id" {
  value       = aws_codecommit_repository.this.repository_id
  description = "The ID of the repository"
}

output "clone_url_ssh" {
  value       = aws_codecommit_repository.this.clone_url_ssh
  description = "The SSH clone URL of the repository"
}

output "clone_url_http" {
  value       = aws_codecommit_repository.this.clone_url_http
  description = "The HTTP clone URL of the repository"
}