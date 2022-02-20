variable "repository_name" {
  type    = string
  default = "MyTestRepository"
  description = "The name of the repository"
}

variable "repository_description" {
  type    = string
  default = "This is the Sample App Repository"
  description = "Repository Description"
}

variable "create_approval_rules" {
  type    = bool
  default = false
  description = "Create an approval policy for the repository"
}

variable "approval_rules" {
  type    = string
  default = <<EOF
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
  description = "The JSON repository approval policy"
}

variable "create_triggers" {
  type    = bool
  default = false
  description = "Create a SNS notification trigger for the repository"
}

variable "triggers" {
  type = any
  default = [
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
  description = "The sns notification triggers"
}

variable "tags" {
  type = map(string)
  default = {
    "Name"        = "MyTestRepository"
    "Description" = "This is the Sample App Repository"
  }
  description = "Tags to apply to the repository"
}
