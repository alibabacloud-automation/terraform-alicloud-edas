Alibaba Cloud EDAS (Enterprise Distributed Application Service) Terraform Module

# terraform-alicloud-edas

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-edas/blob/main/README-CN.md)

Terraform module which creates EDAS (Enterprise Distributed Application Service) resources on Alibaba Cloud. EDAS is a PaaS platform that provides comprehensive application lifecycle management capabilities for microservice and distributed applications. This module helps you create and manage EDAS clusters, applications, deployments, and related resources efficiently. For more information about EDAS, see [Enterprise Distributed Application Service](https://www.alibabacloud.com/product/edas).

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