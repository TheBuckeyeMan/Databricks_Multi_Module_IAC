resource "databricks_cluster" "cost_effective_cluster" {
  cluster_name            = "CostEffectiveCluster"
  spark_version           = "11.3.x-scala2.12" # Use the latest LTS version
  node_type_id            = "m5.large"
  autotermination_minutes = 30

  autoscale {
    min_workers = 1
    max_workers = 2
  }

  aws_attributes {
    instance_profile_arn = "arn:aws:iam::339712758982:instance-profile/DatabricksClusterDeploymentIAM" # Your IAM role to provision cluster - From the roles you provisioned earlier
    availability          = "ON_DEMAND"
    ebs_volume_type       = "GENERAL_PURPOSE_SSD"  # Use gp3
    ebs_volume_count      = 1                     # Number of EBS volumes
    ebs_volume_size       = 32                    # Size in GB
  }
}
