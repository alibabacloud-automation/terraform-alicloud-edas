# Configure the AliCloud Provider
provider "alicloud" {
  region = var.region
}

# Data sources for existing resources
data "alicloud_regions" "current" {
  current = true
}

data "alicloud_zones" "available" {
  available_resource_creation = "VSwitch"
}

data "alicloud_images" "default" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.available.zones[0].id
  cpu_core_count    = 2
  memory_size       = 4
}

# Create VPC for EDAS cluster
resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name_prefix}-vpc"
  cidr_block = "10.0.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "${var.name_prefix}-vswitch"
  cidr_block   = "10.0.1.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.available.zones[0].id
}

# Create security group
resource "alicloud_security_group" "default" {
  security_group_name = "${var.name_prefix}-sg"
  vpc_id              = alicloud_vpc.default.id
}

# Create ECS instance for EDAS cluster
resource "alicloud_instance" "default" {
  availability_zone = data.alicloud_zones.available.zones[0].id
  instance_name     = "${var.name_prefix}-instance"
  image_id          = data.alicloud_images.default.images[0].id
  instance_type     = data.alicloud_instance_types.default.instance_types[0].id
  security_groups   = [alicloud_security_group.default.id]
  vswitch_id        = alicloud_vswitch.default.id
}

# EDAS Module Usage - ECS Application Scenario
module "edas_ecs" {
  source = "../../"

  # Create EDAS namespace
  create_namespace = true
  namespace_config = {
    namespace_logical_id = "${data.alicloud_regions.current.regions[0].id}:tfexampleedas"
    namespace_name       = "${var.name_prefix}-namespace"
    description          = "EDAS namespace for ECS application"
    debug_enable         = false
  }

  # Create EDAS ECS cluster
  create_cluster = true
  cluster_config = {
    cluster_name      = "${var.name_prefix}-cluster"
    cluster_type      = "2" # ECS cluster
    network_mode      = "2" # VPC
    logical_region_id = data.alicloud_regions.current.regions[0].id
    vpc_id            = alicloud_vpc.default.id
  }

  # Create EDAS ECS application
  create_application = true
  application_config = {
    application_name = "${var.name_prefix}-app"
    package_type     = "JAR"
    description      = "EDAS ECS application example"
  }

  # Create deploy groups
  deploy_groups_config = {
    "default" = {
      group_name = "default-group"
    }
  }

  # Create instance cluster attachment
  create_instance_attachment = true
  instance_attachment_config = {
    instance_ids = [alicloud_instance.default.id]
  }

  # Create application deployment
  create_deployment = false
  deployment_config = {
    group_id = null
    war_url  = null
  }
}