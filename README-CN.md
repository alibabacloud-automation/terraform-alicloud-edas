阿里云 EDAS（企业级分布式应用服务）Terraform 模块

# terraform-alicloud-edas

[English](https://github.com/alibabacloud-automation/terraform-alicloud-edas/blob/main/README.md) | 简体中文

用于在阿里云上创建 EDAS（企业级分布式应用服务）资源的 Terraform 模块。EDAS 是一个 PaaS 平台，为微服务和分布式应用程序提供全面的应用生命周期管理能力。该模块帮助您高效地创建和管理 EDAS 集群、应用程序、部署和相关资源。有关 EDAS 的更多信息，请参阅[企业级分布式应用服务](https://www.alibabacloud.com/product/edas)。

## 使用方法

该模块为创建 EDAS 资源提供了灵活的配置选项，包括命名空间、ECS 集群、K8s 集群、应用程序和部署。您可以使用此模块根据需求设置完整的 EDAS 环境或单个组件。

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
  
  # 创建 EDAS 命名空间
  create_namespace = true
  namespace_config = {
    namespace_logical_id = "${data.alicloud_regions.current.regions[0].id}:my-namespace"
    namespace_name       = "my-edas-namespace"
    description          = "应用程序的 EDAS 命名空间"
    debug_enable         = false
  }

  # 创建 EDAS ECS 集群
  create_cluster = true
  cluster_config = {
    cluster_name      = "my-edas-cluster"
    cluster_type      = "2"  # ECS 集群
    network_mode      = "2"  # VPC
    logical_region_id = data.alicloud_regions.current.regions[0].id
    vpc_id            = alicloud_vpc.default.id
  }

  # 创建 EDAS 应用程序
  create_application = true
  application_config = {
    application_name = "my-application"
    package_type     = "JAR"
    description      = "我的 EDAS 应用程序"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-edas/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)