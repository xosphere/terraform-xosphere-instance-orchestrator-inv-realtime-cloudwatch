# Xosphere Instance Orchestration Inventory Realtime Cloudwatch configuration
variable "xosphere_mgmt_account_id" {
  description = "AWS Account IDs of the Xosphere management account"
}

variable "xosphere_mgmt_account_region" {
  description = "AWS Region where the Xosphere management account components are installed"
}

variable "organization_inventory_realtime_updates_submission_role_arn" {
  description = "ARN of the IAM Role in the installed region for event relaying"
}