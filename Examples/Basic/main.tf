provider "aws" {
  region = "us-east-1"
}

module "code_commit" {
  source = "../../"

  repository_name        = "my web app"
  repository_description = "This is the my web app Repository"

  create_approval_rules   = false

  create_triggers        = false

  # Tags
  tags = {
      "Name" : " my web app",
      "Type" : " Web App",
      "Owner": "John Doe",
      "Environment": "Production",
      "Version": "1.0.0"
      "Cost Center": "12345"
  }
}