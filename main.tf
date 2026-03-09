# EDAS Namespace
resource "alicloud_edas_namespace" "namespace" {
  count                = var.create_namespace ? 1 : 0
  namespace_logical_id = var.namespace_config.namespace_logical_id
  namespace_name       = var.namespace_config.namespace_name
  description          = var.namespace_config.description
  debug_enable         = var.namespace_config.debug_enable
}

# EDAS ECS Cluster
resource "alicloud_edas_cluster" "cluster" {
  count             = var.create_cluster ? 1 : 0
  cluster_name      = var.cluster_config.cluster_name
  cluster_type      = var.cluster_config.cluster_type
  network_mode      = var.cluster_config.network_mode
  logical_region_id = var.cluster_config.logical_region_id
  vpc_id            = var.cluster_config.vpc_id
}

# EDAS K8s Cluster
resource "alicloud_edas_k8s_cluster" "k8s_cluster" {
  count         = var.create_k8s_cluster ? 1 : 0
  cs_cluster_id = var.k8s_cluster_config.cs_cluster_id
  namespace_id  = var.k8s_cluster_config.namespace_id != null ? var.k8s_cluster_config.namespace_id : (var.create_namespace ? alicloud_edas_namespace.namespace[0].id : var.namespace_id)
}

# EDAS ECS Application
resource "alicloud_edas_application" "application" {
  count             = var.create_application ? 1 : 0
  application_name  = var.application_config.application_name
  cluster_id        = var.create_cluster ? alicloud_edas_cluster.cluster[0].id : var.cluster_id
  package_type      = var.application_config.package_type
  build_pack_id     = var.application_config.build_pack_id
  descriotion       = var.application_config.description
  health_check_url  = var.application_config.health_check_url
  logical_region_id = var.application_config.logical_region_id
  ecu_info          = var.application_config.ecu_info
  group_id          = var.application_config.group_id
  package_version   = var.application_config.package_version
  war_url           = var.application_config.war_url
}

# EDAS K8s Application
resource "alicloud_edas_k8s_application" "k8s_application" {
  count                   = var.create_k8s_application ? 1 : 0
  application_name        = var.k8s_application_config.application_name
  cluster_id              = var.create_k8s_cluster ? alicloud_edas_k8s_cluster.k8s_cluster[0].id : var.k8s_cluster_id
  package_type            = var.k8s_application_config.package_type
  replicas                = var.k8s_application_config.replicas
  image_url               = var.k8s_application_config.image_url
  application_descriotion = var.k8s_application_config.application_description
  package_url             = var.k8s_application_config.package_url
  package_version         = var.k8s_application_config.package_version
  jdk                     = var.k8s_application_config.jdk
  web_container           = var.k8s_application_config.web_container
  edas_container_version  = var.k8s_application_config.edas_container_version
  limit_mem               = var.k8s_application_config.limit_mem
  requests_mem            = var.k8s_application_config.requests_mem
  requests_m_cpu          = var.k8s_application_config.requests_m_cpu
  limit_m_cpu             = var.k8s_application_config.limit_m_cpu
  command                 = var.k8s_application_config.command
  command_args            = var.k8s_application_config.command_args
  envs                    = var.k8s_application_config.envs
  pre_stop                = var.k8s_application_config.pre_stop
  post_start              = var.k8s_application_config.post_start
  liveness                = var.k8s_application_config.liveness
  readiness               = var.k8s_application_config.readiness
  nas_id                  = var.k8s_application_config.nas_id
  mount_descs             = var.k8s_application_config.mount_descs
  local_volume            = var.k8s_application_config.local_volume
  namespace               = var.k8s_application_config.namespace
  logical_region_id       = var.k8s_application_config.logical_region_id
}

# EDAS Deploy Groups
resource "alicloud_edas_deploy_group" "deploy_groups" {
  for_each   = var.deploy_groups_config
  app_id     = var.create_application ? alicloud_edas_application.application[0].id : var.application_id
  group_name = each.value.group_name
}

# EDAS Application Deployment
resource "alicloud_edas_application_deployment" "deployment" {
  count           = var.create_deployment ? 1 : 0
  app_id          = var.create_application ? alicloud_edas_application.application[0].id : var.application_id
  group_id        = var.deployment_config.group_id
  package_version = var.deployment_config.package_version
  war_url         = var.deployment_config.war_url
}

# EDAS Application Scale
resource "alicloud_edas_application_scale" "scale" {
  count        = var.create_scale ? 1 : 0
  app_id       = var.create_application ? alicloud_edas_application.application[0].id : var.application_id
  deploy_group = var.scale_config.deploy_group
  ecu_info     = var.scale_config.ecu_info
  force_status = var.scale_config.force_status
}

# EDAS Instance Cluster Attachment
resource "alicloud_edas_instance_cluster_attachment" "attachment" {
  count        = var.create_instance_attachment ? 1 : 0
  cluster_id   = var.create_cluster ? alicloud_edas_cluster.cluster[0].id : var.cluster_id
  instance_ids = var.instance_attachment_config.instance_ids
}

# EDAS SLB Attachment
resource "alicloud_edas_slb_attachment" "slb_attachment" {
  count            = var.create_slb_attachment ? 1 : 0
  app_id           = var.create_application ? alicloud_edas_application.application[0].id : var.application_id
  slb_id           = var.slb_attachment_config.slb_id
  slb_ip           = var.slb_attachment_config.slb_ip
  type             = var.slb_attachment_config.type
  listener_port    = var.slb_attachment_config.listener_port
  vserver_group_id = var.slb_attachment_config.vserver_group_id
}

# EDAS K8s SLB Attachment
resource "alicloud_edas_k8s_slb_attachment" "k8s_slb_attachment" {
  count  = var.create_k8s_slb_attachment ? 1 : 0
  app_id = var.create_k8s_application ? alicloud_edas_k8s_application.k8s_application[0].id : var.k8s_application_id

  dynamic "slb_configs" {
    for_each = var.k8s_slb_configs
    content {
      type          = slb_configs.value.type
      name          = slb_configs.value.name
      scheduler     = slb_configs.value.scheduler
      specification = slb_configs.value.specification
      slb_id        = slb_configs.value.slb_id

      dynamic "port_mappings" {
        for_each = slb_configs.value.port_mappings
        content {
          cert_id               = port_mappings.value.cert_id
          loadbalancer_protocol = port_mappings.value.loadbalancer_protocol

          dynamic "service_port" {
            for_each = port_mappings.value.service_port
            content {
              port        = service_port.value.port
              protocol    = service_port.value.protocol
              target_port = service_port.value.target_port
            }
          }
        }
      }
    }
  }
}