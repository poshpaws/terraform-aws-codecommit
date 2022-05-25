# terraform-aws-codecommit-repository
Terraform module for creating aws code commit repository

The following resources will be created

- codecommit repository
- repository approval policy (optional)
- triggers (optional)

Prerequisites (Optional in example 1):

- sns topic
- lambda function
- sqs queue

### Example 1 (Basic - codecommit repository only)    

``` hcl
provider "aws" {
  region = "us-east-1"
}

module "code_commit" {
  source = "../../"

  repository_name        = "my app"
  repository_description = "This is the my app repository"

  create_approval_rules   = false

  create_triggers        = false

  # Tags
  tags = {
      "Name" : " my app",
      "Type" : " Web App",
      "Owner": "John Doe",
      "Environment": "Production",
      "Version": "1.0.0"
      "Cost Center": "12345"
  }
}
```

### Example 2 (Complete - codecommit repository with sns notification triggers and approval policy)

``` hcl
provider "aws" {
  region = "us-east-1"
}

module "code_commit" {
  source = "../../"

  repository_name        = "my app"
  repository_description = "This is the my app Repository"

  create_approval_rules  = true
  approval_rules         = <<EOF
{
    "Version": "2018-11-08",
    "DestinationReferences": ["refs/heads/master"],
    "Statements": [{
        "Type": "Approvers",
        "NumberOfApprovalsNeeded": 2,
        "ApprovalPoolMembers": ["arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*"]
    }]
}
EOF

  create_triggers        = true
  triggers               = [
    {
      "Branches": ["master"],
      "DestinationArn" : "arn:aws:sns:eu-west-1:123456789012:MyTopicMaster",
      "Events" : ["all"],
      "Name" : "Master Branch"
    },
    {
      "Branches": ["develop"],
      "DestinationArn" : "arn:aws:sns:eu-west-1:123456789012:MyTopicDevelop",
      "Events" : ["all"],
      "Name" : "Develop branch"
    }
  ]


  # Tags
  tags = {
      "Name" : " my app",
      "Type" : " Application",
      "Owner": "John Doe",
      "Environment": "Production",
      "Version": "1.0.0"
      "Cost Center": "12345"
  }
}
```
