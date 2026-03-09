# EDAS Namespace outputs
output "namespace_id" {
  description = "The ID of the EDAS namespace"
  value       = var.create_namespace ? alicloud_edas_namespace.namespace[0].id : null
}

output "namespace_logical_id" {
  description = "The logical ID of the EDAS namespace"
  value       = var.create_namespace ? alicloud_edas_namespace.namespace[0].namespace_logical_id : null
}

output "namespace_name" {
  description = "The name of the EDAS namespace"
  value       = var.create_namespace ? alicloud_edas_namespace.namespace[0].namespace_name : null
}

# EDAS ECS Cluster outputs
output "cluster_id" {
  description = "The ID of the EDAS ECS cluster"
  value       = var.create_cluster ? alicloud_edas_cluster.cluster[0].id : null
}

output "cluster_name" {
  description = "The name of the EDAS ECS cluster"
  value       = var.create_cluster ? alicloud_edas_cluster.cluster[0].cluster_name : null
}

output "cluster_type" {
  description = "The type of the EDAS ECS cluster"
  value       = var.create_cluster ? alicloud_edas_cluster.cluster[0].cluster_type : null
}

# EDAS K8s Cluster outputs
output "k8s_cluster_id" {
  description = "The ID of the EDAS K8s cluster"
  value       = var.create_k8s_cluster ? alicloud_edas_k8s_cluster.k8s_cluster[0].id : null
}

output "k8s_cluster_name" {
  description = "The name of the EDAS K8s cluster"
  value       = var.create_k8s_cluster ? alicloud_edas_k8s_cluster.k8s_cluster[0].cluster_name : null
}

output "k8s_cluster_import_status" {
  description = "The import status of the EDAS K8s cluster"
  value       = var.create_k8s_cluster ? alicloud_edas_k8s_cluster.k8s_cluster[0].cluster_import_status : null
}

# EDAS ECS Application outputs
output "application_id" {
  description = "The ID of the EDAS ECS application"
  value       = var.create_application ? alicloud_edas_application.application[0].id : null
}

output "application_name" {
  description = "The name of the EDAS ECS application"
  value       = var.create_application ? alicloud_edas_application.application[0].application_name : null
}

output "application_package_type" {
  description = "The package type of the EDAS ECS application"
  value       = var.create_application ? alicloud_edas_application.application[0].package_type : null
}

# EDAS K8s Application outputs
output "k8s_application_id" {
  description = "The ID of the EDAS K8s application"
  value       = var.create_k8s_application ? alicloud_edas_k8s_application.k8s_application[0].id : null
}

output "k8s_application_name" {
  description = "The name of the EDAS K8s application"
  value       = var.create_k8s_application ? alicloud_edas_k8s_application.k8s_application[0].application_name : null
}

output "k8s_application_replicas" {
  description = "The replicas of the EDAS K8s application"
  value       = var.create_k8s_application ? alicloud_edas_k8s_application.k8s_application[0].replicas : null
}

# EDAS Deploy Groups outputs
output "deploy_groups_ids" {
  description = "The IDs of the EDAS deploy groups"
  value       = { for k, v in alicloud_edas_deploy_group.deploy_groups : k => v.id }
}

output "deploy_groups_names" {
  description = "The names of the EDAS deploy groups"
  value       = { for k, v in alicloud_edas_deploy_group.deploy_groups : k => v.group_name }
}

# EDAS Application Deployment outputs
output "deployment_id" {
  description = "The ID of the EDAS application deployment"
  value       = var.create_deployment ? alicloud_edas_application_deployment.deployment[0].id : null
}

output "deployment_package_version" {
  description = "The package version of the EDAS application deployment"
  value       = var.create_deployment ? alicloud_edas_application_deployment.deployment[0].package_version : null
}

# EDAS Application Scale outputs
output "scale_id" {
  description = "The ID of the EDAS application scale"
  value       = var.create_scale ? alicloud_edas_application_scale.scale[0].id : null
}

output "scale_ecc_info" {
  description = "The ECC information of the EDAS application scale"
  value       = var.create_scale ? alicloud_edas_application_scale.scale[0].ecc_info : null
}

# EDAS Instance Cluster Attachment outputs
output "attachment_id" {
  description = "The ID of the EDAS instance cluster attachment"
  value       = var.create_instance_attachment ? alicloud_edas_instance_cluster_attachment.attachment[0].id : null
}

output "attachment_status_map" {
  description = "The status map of the EDAS instance cluster attachment"
  value       = var.create_instance_attachment ? alicloud_edas_instance_cluster_attachment.attachment[0].status_map : null
}

output "attachment_ecu_map" {
  description = "The ECU map of the EDAS instance cluster attachment"
  value       = var.create_instance_attachment ? alicloud_edas_instance_cluster_attachment.attachment[0].ecu_map : null
}

output "attachment_cluster_member_ids" {
  description = "The cluster member IDs of the EDAS instance cluster attachment"
  value       = var.create_instance_attachment ? alicloud_edas_instance_cluster_attachment.attachment[0].cluster_member_ids : null
}

# EDAS SLB Attachment outputs
output "slb_attachment_id" {
  description = "The ID of the EDAS SLB attachment"
  value       = var.create_slb_attachment ? alicloud_edas_slb_attachment.slb_attachment[0].id : null
}

output "slb_attachment_status" {
  description = "The SLB status of the EDAS SLB attachment"
  value       = var.create_slb_attachment ? alicloud_edas_slb_attachment.slb_attachment[0].slb_status : null
}

output "slb_attachment_vswitch_id" {
  description = "The VSwitch ID of the EDAS SLB attachment"
  value       = var.create_slb_attachment ? alicloud_edas_slb_attachment.slb_attachment[0].vswitch_id : null
}

# EDAS K8s SLB Attachment outputs
output "k8s_slb_attachment_id" {
  description = "The ID of the EDAS K8s SLB attachment"
  value       = var.create_k8s_slb_attachment ? alicloud_edas_k8s_slb_attachment.k8s_slb_attachment[0].id : null
}