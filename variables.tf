# Namespace configuration
variable "create_namespace" {
  type        = bool
  description = "Whether to create a new EDAS namespace"
  default     = false
}

variable "namespace_id" {
  type        = string
  description = "The ID of an existing EDAS namespace. Required when create_namespace is false"
  default     = null
}

variable "namespace_config" {
  type = object({
    namespace_logical_id = string
    namespace_name       = string
    description          = optional(string, null)
    debug_enable         = optional(bool, false)
  })
  description = "The configuration for EDAS namespace. The attributes 'namespace_logical_id' and 'namespace_name' are required"
  default = {
    namespace_logical_id = null
    namespace_name       = null
  }
}

# ECS Cluster configuration
variable "create_cluster" {
  type        = bool
  description = "Whether to create a new EDAS ECS cluster"
  default     = false
}

variable "cluster_id" {
  type        = string
  description = "The ID of an existing EDAS cluster. Required when create_cluster is false"
  default     = null
}

variable "cluster_config" {
  type = object({
    cluster_name      = string
    cluster_type      = string
    network_mode      = string
    logical_region_id = optional(string, null)
    vpc_id            = optional(string, null)
  })
  description = "The configuration for EDAS ECS cluster. The attributes 'cluster_name', 'cluster_type' and 'network_mode' are required"
  default = {
    cluster_name = null
    cluster_type = null
    network_mode = null
  }
}

# K8s Cluster configuration
variable "create_k8s_cluster" {
  type        = bool
  description = "Whether to create a new EDAS K8s cluster"
  default     = false
}

variable "k8s_cluster_id" {
  type        = string
  description = "The ID of an existing EDAS K8s cluster. Required when create_k8s_cluster is false"
  default     = null
}

variable "k8s_cluster_config" {
  type = object({
    cs_cluster_id = string
    namespace_id  = optional(string, null)
  })
  description = "The configuration for EDAS K8s cluster. The attribute 'cs_cluster_id' is required"
  default = {
    cs_cluster_id = null
  }
}

# ECS Application configuration
variable "create_application" {
  type        = bool
  description = "Whether to create a new EDAS ECS application"
  default     = false
}

variable "application_id" {
  type        = string
  description = "The ID of an existing EDAS application. Required when create_application is false"
  default     = null
}

variable "application_config" {
  type = object({
    application_name  = string
    package_type      = string
    build_pack_id     = optional(string, null)
    description       = optional(string, null)
    health_check_url  = optional(string, null)
    logical_region_id = optional(string, null)
    ecu_info          = optional(list(string), null)
    group_id          = optional(string, null)
    package_version   = optional(string, null)
    war_url           = optional(string, null)
  })
  description = "The configuration for EDAS ECS application. The attributes 'application_name' and 'package_type' are required"
  default = {
    application_name = null
    package_type     = null
  }
}

# K8s Application configuration
variable "create_k8s_application" {
  type        = bool
  description = "Whether to create a new EDAS K8s application"
  default     = false
}

variable "k8s_application_id" {
  type        = string
  description = "The ID of an existing EDAS K8s application. Required when create_k8s_application is false"
  default     = null
}

variable "k8s_application_config" {
  type = object({
    application_name        = string
    package_type            = optional(string, null)
    replicas                = optional(number, null)
    image_url               = optional(string, null)
    application_description = optional(string, null)
    package_url             = optional(string, null)
    package_version         = optional(string, null)
    jdk                     = optional(string, null)
    web_container           = optional(string, null)
    edas_container_version  = optional(string, null)
    limit_mem               = optional(number, null)
    requests_mem            = optional(number, null)
    requests_m_cpu          = optional(number, null)
    limit_m_cpu             = optional(number, null)
    command                 = optional(string, null)
    command_args            = optional(list(string), null)
    envs                    = optional(map(string), null)
    pre_stop                = optional(string, null)
    post_start              = optional(string, null)
    liveness                = optional(string, null)
    readiness               = optional(string, null)
    nas_id                  = optional(string, null)
    mount_descs             = optional(string, null)
    local_volume            = optional(string, null)
    namespace               = optional(string, null)
    logical_region_id       = optional(string, null)
  })
  description = "The configuration for EDAS K8s application. The attribute 'application_name' is required"
  default = {
    application_name = null
  }
}

# Deploy Groups configuration
variable "deploy_groups_config" {
  type = map(object({
    group_name = string
  }))
  description = "The configuration for EDAS deploy groups. Each group requires 'group_name'"
  default     = {}
}

# Application Deployment configuration
variable "create_deployment" {
  type        = bool
  description = "Whether to create EDAS application deployment"
  default     = false
}

variable "deployment_config" {
  type = object({
    group_id        = string
    package_version = optional(string, null)
    war_url         = string
  })
  description = "The configuration for EDAS application deployment. The attributes 'group_id' and 'war_url' are required"
  default = {
    group_id = null
    war_url  = null
  }
}

# Application Scale configuration
variable "create_scale" {
  type        = bool
  description = "Whether to create EDAS application scale"
  default     = false
}

variable "scale_config" {
  type = object({
    deploy_group = string
    ecu_info     = list(string)
    force_status = optional(bool, null)
  })
  description = "The configuration for EDAS application scale. The attributes 'deploy_group' and 'ecu_info' are required"
  default = {
    deploy_group = null
    ecu_info     = null
  }
}

# Instance Cluster Attachment configuration
variable "create_instance_attachment" {
  type        = bool
  description = "Whether to create EDAS instance cluster attachment"
  default     = false
}

variable "instance_attachment_config" {
  type = object({
    instance_ids = list(string)
  })
  description = "The configuration for EDAS instance cluster attachment. The attribute 'instance_ids' is required"
  default = {
    instance_ids = null
  }
}

# SLB Attachment configuration
variable "create_slb_attachment" {
  type        = bool
  description = "Whether to create EDAS SLB attachment"
  default     = false
}

variable "slb_attachment_config" {
  type = object({
    slb_id           = string
    slb_ip           = string
    type             = string
    listener_port    = optional(string, null)
    vserver_group_id = optional(string, null)
  })
  description = "The configuration for EDAS SLB attachment. The attributes 'slb_id', 'slb_ip' and 'type' are required"
  default = {
    slb_id = null
    slb_ip = null
    type   = null
  }
}

# K8s SLB Attachment configuration
variable "create_k8s_slb_attachment" {
  type        = bool
  description = "Whether to create EDAS K8s SLB attachment"
  default     = false
}

variable "k8s_slb_configs" {
  type = list(object({
    type          = string
    name          = optional(string, null)
    scheduler     = string
    specification = optional(string, null)
    slb_id        = optional(string, null)
    port_mappings = list(object({
      cert_id               = optional(string, null)
      loadbalancer_protocol = string
      service_port = list(object({
        port        = number
        protocol    = string
        target_port = number
      }))
    }))
  }))
  description = "The configuration for EDAS K8s SLB attachment. Each SLB config requires 'type' and 'scheduler'"
  default     = []
}