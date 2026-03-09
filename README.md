Alibaba Cloud EDAS (Enterprise Distributed Application Service) Terraform Module

# terraform-alicloud-edas

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-edas/blob/main/README-CN.md)

Terraform module which creates EDAS (Enterprise Distributed Application Service) resources on Alibaba Cloud. [EDAS](https://www.alibabacloud.com/product/edas) is a PaaS platform that provides comprehensive application lifecycle management capabilities for microservice and distributed applications. This module helps you create and manage EDAS clusters, applications, deployments, and related resources efficiently.

## Usage

This module provides flexible configuration options for creating EDAS resources including namespaces, ECS clusters, K8s clusters, applications, and deployments. You can use this module to set up a complete EDAS environment or individual components based on your requirements.

```terraform
data "alicloud_regions" "current" {
  current = true
}

data "alicloud_zones" "available" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = "edas-vpc"
  cidr_block = "10.0.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "edas-vswitch"
  cidr_block   = "10.0.1.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.available.zones[0].id
}

module "edas" {
  source = "alibabacloud-automation/edas/alicloud"
  
  # Create EDAS namespace
  create_namespace = true
  namespace_config = {
    namespace_logical_id = "${data.alicloud_regions.current.regions[0].id}:my-namespace"
    namespace_name       = "my-edas-namespace"
    description          = "EDAS namespace for applications"
    debug_enable         = false
  }

  # Create EDAS ECS cluster
  create_cluster = true
  cluster_config = {
    cluster_name      = "my-edas-cluster"
    cluster_type      = "2"  # ECS cluster
    network_mode      = "2"  # VPC
    logical_region_id = data.alicloud_regions.current.regions[0].id
    vpc_id            = alicloud_vpc.default.id
  }

  # Create EDAS application
  create_application = true
  application_config = {
    application_name = "my-application"
    package_type     = "JAR"
    description      = "My EDAS application"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-edas/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.173.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.173.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_edas_application.application](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_application) | resource |
| [alicloud_edas_application_deployment.deployment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_application_deployment) | resource |
| [alicloud_edas_application_scale.scale](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_application_scale) | resource |
| [alicloud_edas_cluster.cluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_cluster) | resource |
| [alicloud_edas_deploy_group.deploy_groups](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_deploy_group) | resource |
| [alicloud_edas_instance_cluster_attachment.attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_instance_cluster_attachment) | resource |
| [alicloud_edas_k8s_application.k8s_application](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_k8s_application) | resource |
| [alicloud_edas_k8s_cluster.k8s_cluster](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_k8s_cluster) | resource |
| [alicloud_edas_k8s_slb_attachment.k8s_slb_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_k8s_slb_attachment) | resource |
| [alicloud_edas_namespace.namespace](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_namespace) | resource |
| [alicloud_edas_slb_attachment.slb_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/edas_slb_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_config"></a> [application\_config](#input\_application\_config) | The configuration for EDAS ECS application. The attributes 'application\_name' and 'package\_type' are required | <pre>object({<br/>    application_name  = string<br/>    package_type      = string<br/>    build_pack_id     = optional(string, null)<br/>    description       = optional(string, null)<br/>    health_check_url  = optional(string, null)<br/>    logical_region_id = optional(string, null)<br/>    ecu_info          = optional(list(string), null)<br/>    group_id          = optional(string, null)<br/>    package_version   = optional(string, null)<br/>    war_url           = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "application_name": null,<br/>  "package_type": null<br/>}</pre> | no |
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | The ID of an existing EDAS application. Required when create\_application is false | `string` | `null` | no |
| <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config) | The configuration for EDAS ECS cluster. The attributes 'cluster\_name', 'cluster\_type' and 'network\_mode' are required | <pre>object({<br/>    cluster_name      = string<br/>    cluster_type      = string<br/>    network_mode      = string<br/>    logical_region_id = optional(string, null)<br/>    vpc_id            = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "cluster_name": null,<br/>  "cluster_type": null,<br/>  "network_mode": null<br/>}</pre> | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of an existing EDAS cluster. Required when create\_cluster is false | `string` | `null` | no |
| <a name="input_create_application"></a> [create\_application](#input\_create\_application) | Whether to create a new EDAS ECS application | `bool` | `false` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Whether to create a new EDAS ECS cluster | `bool` | `false` | no |
| <a name="input_create_deployment"></a> [create\_deployment](#input\_create\_deployment) | Whether to create EDAS application deployment | `bool` | `false` | no |
| <a name="input_create_instance_attachment"></a> [create\_instance\_attachment](#input\_create\_instance\_attachment) | Whether to create EDAS instance cluster attachment | `bool` | `false` | no |
| <a name="input_create_k8s_application"></a> [create\_k8s\_application](#input\_create\_k8s\_application) | Whether to create a new EDAS K8s application | `bool` | `false` | no |
| <a name="input_create_k8s_cluster"></a> [create\_k8s\_cluster](#input\_create\_k8s\_cluster) | Whether to create a new EDAS K8s cluster | `bool` | `false` | no |
| <a name="input_create_k8s_slb_attachment"></a> [create\_k8s\_slb\_attachment](#input\_create\_k8s\_slb\_attachment) | Whether to create EDAS K8s SLB attachment | `bool` | `false` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create a new EDAS namespace | `bool` | `false` | no |
| <a name="input_create_scale"></a> [create\_scale](#input\_create\_scale) | Whether to create EDAS application scale | `bool` | `false` | no |
| <a name="input_create_slb_attachment"></a> [create\_slb\_attachment](#input\_create\_slb\_attachment) | Whether to create EDAS SLB attachment | `bool` | `false` | no |
| <a name="input_deploy_groups_config"></a> [deploy\_groups\_config](#input\_deploy\_groups\_config) | The configuration for EDAS deploy groups. Each group requires 'group\_name' | <pre>map(object({<br/>    group_name = string<br/>  }))</pre> | `{}` | no |
| <a name="input_deployment_config"></a> [deployment\_config](#input\_deployment\_config) | The configuration for EDAS application deployment. The attributes 'group\_id' and 'war\_url' are required | <pre>object({<br/>    group_id        = string<br/>    package_version = optional(string, null)<br/>    war_url         = string<br/>  })</pre> | <pre>{<br/>  "group_id": null,<br/>  "war_url": null<br/>}</pre> | no |
| <a name="input_instance_attachment_config"></a> [instance\_attachment\_config](#input\_instance\_attachment\_config) | The configuration for EDAS instance cluster attachment. The attribute 'instance\_ids' is required | <pre>object({<br/>    instance_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "instance_ids": null<br/>}</pre> | no |
| <a name="input_k8s_application_config"></a> [k8s\_application\_config](#input\_k8s\_application\_config) | The configuration for EDAS K8s application. The attribute 'application\_name' is required | <pre>object({<br/>    application_name        = string<br/>    package_type            = optional(string, null)<br/>    replicas                = optional(number, null)<br/>    image_url               = optional(string, null)<br/>    application_description = optional(string, null)<br/>    package_url             = optional(string, null)<br/>    package_version         = optional(string, null)<br/>    jdk                     = optional(string, null)<br/>    web_container           = optional(string, null)<br/>    edas_container_version  = optional(string, null)<br/>    limit_mem               = optional(number, null)<br/>    requests_mem            = optional(number, null)<br/>    requests_m_cpu          = optional(number, null)<br/>    limit_m_cpu             = optional(number, null)<br/>    command                 = optional(string, null)<br/>    command_args            = optional(list(string), null)<br/>    envs                    = optional(map(string), null)<br/>    pre_stop                = optional(string, null)<br/>    post_start              = optional(string, null)<br/>    liveness                = optional(string, null)<br/>    readiness               = optional(string, null)<br/>    nas_id                  = optional(string, null)<br/>    mount_descs             = optional(string, null)<br/>    local_volume            = optional(string, null)<br/>    namespace               = optional(string, null)<br/>    logical_region_id       = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "application_name": null<br/>}</pre> | no |
| <a name="input_k8s_application_id"></a> [k8s\_application\_id](#input\_k8s\_application\_id) | The ID of an existing EDAS K8s application. Required when create\_k8s\_application is false | `string` | `null` | no |
| <a name="input_k8s_cluster_config"></a> [k8s\_cluster\_config](#input\_k8s\_cluster\_config) | The configuration for EDAS K8s cluster. The attribute 'cs\_cluster\_id' is required | <pre>object({<br/>    cs_cluster_id = string<br/>    namespace_id  = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "cs_cluster_id": null<br/>}</pre> | no |
| <a name="input_k8s_cluster_id"></a> [k8s\_cluster\_id](#input\_k8s\_cluster\_id) | The ID of an existing EDAS K8s cluster. Required when create\_k8s\_cluster is false | `string` | `null` | no |
| <a name="input_k8s_slb_configs"></a> [k8s\_slb\_configs](#input\_k8s\_slb\_configs) | The configuration for EDAS K8s SLB attachment. Each SLB config requires 'type' and 'scheduler' | <pre>list(object({<br/>    type          = string<br/>    name          = optional(string, null)<br/>    scheduler     = string<br/>    specification = optional(string, null)<br/>    slb_id        = optional(string, null)<br/>    port_mappings = list(object({<br/>      cert_id               = optional(string, null)<br/>      loadbalancer_protocol = string<br/>      service_port = list(object({<br/>        port        = number<br/>        protocol    = string<br/>        target_port = number<br/>      }))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_namespace_config"></a> [namespace\_config](#input\_namespace\_config) | The configuration for EDAS namespace. The attributes 'namespace\_logical\_id' and 'namespace\_name' are required | <pre>object({<br/>    namespace_logical_id = string<br/>    namespace_name       = string<br/>    description          = optional(string, null)<br/>    debug_enable         = optional(bool, false)<br/>  })</pre> | <pre>{<br/>  "namespace_logical_id": null,<br/>  "namespace_name": null<br/>}</pre> | no |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | The ID of an existing EDAS namespace. Required when create\_namespace is false | `string` | `null` | no |
| <a name="input_scale_config"></a> [scale\_config](#input\_scale\_config) | The configuration for EDAS application scale. The attributes 'deploy\_group' and 'ecu\_info' are required | <pre>object({<br/>    deploy_group = string<br/>    ecu_info     = list(string)<br/>    force_status = optional(bool, null)<br/>  })</pre> | <pre>{<br/>  "deploy_group": null,<br/>  "ecu_info": null<br/>}</pre> | no |
| <a name="input_slb_attachment_config"></a> [slb\_attachment\_config](#input\_slb\_attachment\_config) | The configuration for EDAS SLB attachment. The attributes 'slb\_id', 'slb\_ip' and 'type' are required | <pre>object({<br/>    slb_id           = string<br/>    slb_ip           = string<br/>    type             = string<br/>    listener_port    = optional(string, null)<br/>    vserver_group_id = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "slb_id": null,<br/>  "slb_ip": null,<br/>  "type": null<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The ID of the EDAS ECS application |
| <a name="output_application_name"></a> [application\_name](#output\_application\_name) | The name of the EDAS ECS application |
| <a name="output_application_package_type"></a> [application\_package\_type](#output\_application\_package\_type) | The package type of the EDAS ECS application |
| <a name="output_attachment_cluster_member_ids"></a> [attachment\_cluster\_member\_ids](#output\_attachment\_cluster\_member\_ids) | The cluster member IDs of the EDAS instance cluster attachment |
| <a name="output_attachment_ecu_map"></a> [attachment\_ecu\_map](#output\_attachment\_ecu\_map) | The ECU map of the EDAS instance cluster attachment |
| <a name="output_attachment_id"></a> [attachment\_id](#output\_attachment\_id) | The ID of the EDAS instance cluster attachment |
| <a name="output_attachment_status_map"></a> [attachment\_status\_map](#output\_attachment\_status\_map) | The status map of the EDAS instance cluster attachment |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the EDAS ECS cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EDAS ECS cluster |
| <a name="output_cluster_type"></a> [cluster\_type](#output\_cluster\_type) | The type of the EDAS ECS cluster |
| <a name="output_deploy_groups_ids"></a> [deploy\_groups\_ids](#output\_deploy\_groups\_ids) | The IDs of the EDAS deploy groups |
| <a name="output_deploy_groups_names"></a> [deploy\_groups\_names](#output\_deploy\_groups\_names) | The names of the EDAS deploy groups |
| <a name="output_deployment_id"></a> [deployment\_id](#output\_deployment\_id) | The ID of the EDAS application deployment |
| <a name="output_deployment_package_version"></a> [deployment\_package\_version](#output\_deployment\_package\_version) | The package version of the EDAS application deployment |
| <a name="output_k8s_application_id"></a> [k8s\_application\_id](#output\_k8s\_application\_id) | The ID of the EDAS K8s application |
| <a name="output_k8s_application_name"></a> [k8s\_application\_name](#output\_k8s\_application\_name) | The name of the EDAS K8s application |
| <a name="output_k8s_application_replicas"></a> [k8s\_application\_replicas](#output\_k8s\_application\_replicas) | The replicas of the EDAS K8s application |
| <a name="output_k8s_cluster_id"></a> [k8s\_cluster\_id](#output\_k8s\_cluster\_id) | The ID of the EDAS K8s cluster |
| <a name="output_k8s_cluster_import_status"></a> [k8s\_cluster\_import\_status](#output\_k8s\_cluster\_import\_status) | The import status of the EDAS K8s cluster |
| <a name="output_k8s_cluster_name"></a> [k8s\_cluster\_name](#output\_k8s\_cluster\_name) | The name of the EDAS K8s cluster |
| <a name="output_k8s_slb_attachment_id"></a> [k8s\_slb\_attachment\_id](#output\_k8s\_slb\_attachment\_id) | The ID of the EDAS K8s SLB attachment |
| <a name="output_namespace_id"></a> [namespace\_id](#output\_namespace\_id) | The ID of the EDAS namespace |
| <a name="output_namespace_logical_id"></a> [namespace\_logical\_id](#output\_namespace\_logical\_id) | The logical ID of the EDAS namespace |
| <a name="output_namespace_name"></a> [namespace\_name](#output\_namespace\_name) | The name of the EDAS namespace |
| <a name="output_scale_ecc_info"></a> [scale\_ecc\_info](#output\_scale\_ecc\_info) | The ECC information of the EDAS application scale |
| <a name="output_scale_id"></a> [scale\_id](#output\_scale\_id) | The ID of the EDAS application scale |
| <a name="output_slb_attachment_id"></a> [slb\_attachment\_id](#output\_slb\_attachment\_id) | The ID of the EDAS SLB attachment |
| <a name="output_slb_attachment_status"></a> [slb\_attachment\_status](#output\_slb\_attachment\_status) | The SLB status of the EDAS SLB attachment |
| <a name="output_slb_attachment_vswitch_id"></a> [slb\_attachment\_vswitch\_id](#output\_slb\_attachment\_vswitch\_id) | The VSwitch ID of the EDAS SLB attachment |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)