data "aws_region" "current" {}

locals {
  lambda_function__xosphere_organization_inventory_updates_submitter = "xosphere-instance-orchestrator-org-inv-upd-sub"
}

resource "aws_cloudwatch_event_rule" "xosphere_organization_inventory_realtime_updates_cloudwatch_rule" {
  name = join("", [ local.lambda_function__xosphere_organization_inventory_updates_submitter, "-event-rule"])
  description = "CloudWatch Event trigger for EC2 state change"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Instance State-change Notification"
  ],
  "detail": {
    "state": [
      "pending",
      "terminated",
      "stopped"
    ]
  }
}
PATTERN
  is_enabled = true
}

resource "aws_cloudwatch_event_target" "xosphere_organization_inventory_realtime_updates_cloudwatch_target" {
  arn = join(":", ["arn:aws:events", var.xosphere_mgmt_account_region, var.xosphere_mgmt_account_id, "event-bus/xosphere-instance-orchestrator-org-inv-realtime-updates-bus" ])
  rule = aws_cloudwatch_event_rule.xosphere_organization_inventory_realtime_updates_cloudwatch_rule.name
  target_id = join("", [ local.lambda_function__xosphere_organization_inventory_updates_submitter, "-event-rule-target"])
  role_arn = var.organization_inventory_realtime_updates_submission_role_arn
}