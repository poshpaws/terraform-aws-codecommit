resource "aws_codecommit_repository" "this" {
  repository_name = var.repository_name
  description     = var.repository_description
  tags = var.tags
}

resource "aws_codecommit_approval_rule_template" "this" {
  count       = var.create_approval_rules ? 1 : 0
  name        = "${var.repository_name} approval rule"
  description = "This is an approval rule for ${var.repository_name}"
  content     = var.approval_rules
}

resource "aws_codecommit_approval_rule_template_association" "this" {
  count                       = var.create_approval_rules ? 1 : 0
  approval_rule_template_name = aws_codecommit_approval_rule_template.this[0].name
  repository_name             = aws_codecommit_repository.this.repository_name
}

resource "aws_codecommit_trigger" "this" {
  count           = var.create_triggers ? 1 : 0
  repository_name = aws_codecommit_repository.this.repository_name

  dynamic "trigger" {
    for_each = var.triggers
    content {
      name            = trigger.value.Name
      events          = trigger.value.Events
      destination_arn = trigger.value.DestinationArn
    }
  }
}
