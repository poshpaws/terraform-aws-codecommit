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