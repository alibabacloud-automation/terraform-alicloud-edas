# VPC outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.default.id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.default.id
}

# ECS instance outputs
output "instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.default.id
}

# EDAS outputs
output "edas_namespace_id" {
  description = "The ID of the EDAS namespace"
  value       = module.edas_ecs.namespace_id
}

output "edas_cluster_id" {
  description = "The ID of the EDAS cluster"
  value       = module.edas_ecs.cluster_id
}

output "edas_application_id" {
  description = "The ID of the EDAS application"
  value       = module.edas_ecs.application_id
}

output "edas_deploy_groups_ids" {
  description = "The IDs of the EDAS deploy groups"
  value       = module.edas_ecs.deploy_groups_ids
}

output "edas_deployment_id" {
  description = "The ID of the EDAS deployment"
  value       = module.edas_ecs.deployment_id
}

output "edas_attachment_id" {
  description = "The ID of the EDAS instance attachment"
  value       = module.edas_ecs.attachment_id
}