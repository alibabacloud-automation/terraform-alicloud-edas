# Complete

This example demonstrates how to use the EDAS Terraform module to create a complete EDAS environment with ECS cluster, application, and deployment.

## Architecture

This example creates:

1. **VPC Infrastructure**:
   - VPC with CIDR 10.0.0.0/16
   - VSwitch in the first available zone
   - Security group for ECS instances

2. **ECS Resources**:
   - ECS instance for EDAS cluster node

3. **EDAS Resources**:
   - EDAS namespace
   - EDAS ECS cluster
   - EDAS application
   - Deploy group
   - Instance cluster attachment
   - Application deployment

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The region where resources will be created | `string` | `"cn-hangzhou"` | no |
| name_prefix | The name prefix for all resources | `string` | `"tf-example-edas"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| vswitch_id | The ID of the VSwitch |
| instance_id | The ID of the ECS instance |
| edas_namespace_id | The ID of the EDAS namespace |
| edas_cluster_id | The ID of the EDAS cluster |
| edas_application_id | The ID of the EDAS application |
| edas_deploy_groups_ids | The IDs of the EDAS deploy groups |
| edas_deployment_id | The ID of the EDAS deployment |
| edas_attachment_id | The ID of the EDAS instance attachment |

## Notes

- This example uses a sample JAR file from Alibaba Cloud's OSS for demonstration purposes
- Make sure you have the necessary permissions to create EDAS resources in your account
- The ECS instance created will be automatically added to the EDAS cluster
- The deployment uses the "all" group ID to deploy to all available instances
