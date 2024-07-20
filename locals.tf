locals {
  project_name = "${var.app_name}-${var.env_name}"
  common_tags = {
    created-by   = "Terraform"
    project-name = local.project_name
  }
  azs_set  = toset(data.aws_availability_zones.available.names)
  azs_list = tolist(data.aws_availability_zones.available.names)
}