# Terraform ECS Fargate Practice

This repository contains the infrastructure-as-code practice for deploying an AWS ECS Fargate service using Terraform.

## Project Overview

The goal of this project is to build a working ECS Fargate deployment with the required AWS networking and IAM resources. The project is structured to cover the following areas:

- VPC and subnet creation for secure networking.
- ECS cluster definition for container orchestration.
- ECS task definition and Fargate service configuration.
- Load balancing and service discovery if required.
- IAM roles and policies to allow ECS tasks to run and connect to AWS services.

## What has been implemented

### Terraform project setup

- Initialized the Terraform project with the necessary provider configuration.
- Defined backend or local state management depending on the environment.
- Added variable definitions and outputs for easier reuse and testing.

### Networking

- Created an AWS VPC to host the ECS service.
- Defined public and private subnets for Fargate tasks and load balancer placement.
- Created security groups to control inbound and outbound traffic.
- Configured routing tables and internet gateway for external access where needed.

### ECS resources

- Defined an ECS cluster as the core of the deployment.
- Created an ECS task definition with Fargate compatibility.
- Added container definitions and task CPU/memory settings.
- Configured an ECS service to keep the desired number of tasks running.

### IAM and permissions

- Created IAM roles for ECS task execution.
- Attached the AWS managed policy for ECS task execution role.
- Defined additional IAM permissions if the container needs access to other AWS resources.

## Detailed explanation of key components

### VPC and Networking

A VPC is the isolated network environment in AWS. In this project, the VPC is used to separate ECS resources from the public internet and to provide private networking for containers.

- `aws_vpc`: Creates the network boundary.
- `aws_subnet`: Defines the subnets where ECS tasks and load balancers will run.
- `aws_security_group`: Controls traffic to the ECS service and other resources.
- `aws_internet_gateway` and route tables: Allow traffic from the internet to reach public resources when required.

### ECS Cluster and Service

The ECS cluster is the logical grouping of tasks and services. Fargate lets ECS run containers without managing EC2 instances.

- `aws_ecs_cluster`: The cluster resource that holds services and tasks.
- `aws_ecs_task_definition`: Describes the container image, CPU/memory, and networking mode.
- `aws_ecs_service`: Manages the running tasks and ensures the desired count is maintained.

### Task Definition

Task definitions are the blueprint for running containers.

- Container image: Reference to a Docker image stored in ECR or a public registry.
- Resource configuration: CPU and memory allocation for Fargate tasks.
- Port mappings: Expose container ports to the service or load balancer.
- Environment variables: Pass runtime configuration into the container.

### IAM Roles and Policies

ECS tasks require an execution role to pull images and send logs.

- `aws_iam_role`: Role assumed by ECS tasks.
- `aws_iam_role_policy_attachment`: Attaches the ECS task execution managed policy.
- Optional custom policies: Grant permissions for S3, CloudWatch, or other AWS services used by the container.

## How to use this repository

1. Install Terraform.
2. Configure AWS credentials locally or in your environment.
3. Run `terraform init` to initialize the project.
4. Run `terraform plan` to review the changes.
5. Run `terraform apply` to create the infrastructure.

## Current status

- Terraform configuration is initialized.
- Core ECS Fargate resources are defined.
- Networking and IAM resources are included.
- Terraform plan was validated and `terraform apply` completed successfully.

## Next steps

- No remaining ECS task or service configuration changes are required.
- Maintain the deployment and update infrastructure as requirements evolve.
- Keep the README current with any future architecture changes.
