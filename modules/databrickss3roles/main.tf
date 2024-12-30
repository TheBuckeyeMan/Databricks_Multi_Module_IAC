resource "aws_iam_role" "databricks_s3_access" {
  name = "DatabricksS3Access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
            "AWS": "arn:aws:iam::414351767826:root"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for Specific Buckets
resource "aws_iam_policy" "databricks_s3_limited_access" {
  name = "DatabricksS3LimitedAccessYoutubeBuckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:*" # Allows all S3 actions
        ],
        Resource = [
          "arn:aws:s3:::raws3bucket-databricks-1220-16492640",   
          "arn:aws:s3:::raws3bucket-databricks-1220-16492640/*", 
          "arn:aws:s3:::trusteds3bucket-databricks-1220-16492640",    
          "arn:aws:s3:::trusteds3bucket-databricks-1220-16492640/*",   
          "arn:aws:s3:::refineds3bucket-databricks-1220-16492640",  
          "arn:aws:s3:::refineds3bucket-databricks-1220-16492640/*" 
        ]
      }
    ]
  })
}

# Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "databricks_s3_access_attach" {
  role       = aws_iam_role.databricks_s3_access.name
  policy_arn = aws_iam_policy.databricks_s3_limited_access.arn
}




//Add in IAM Policy for Cluster Deployment
resource "aws_iam_role" "databricks_cluster_deployment_iam" {
  name = "DatabricksClusterDeploymentIAM"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          "AWS": "arn:aws:iam::414351767826:root"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

// Policy for EC2 and EBS Access
resource "aws_iam_policy" "databricks_ec2_ebs_policy" {
  name = "DatabricksEC2EBSAccess"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:RunInstances",
          "ec2:DescribeInstances",
          "ec2:TerminateInstances",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:AttachVolume",
          "ec2:DeleteVolume",
          "ec2:DescribeVolumes"
        ],
        Resource = "*"
      }
    ]
  })
}

// Policy for CloudWatch Access
resource "aws_iam_policy" "databricks_cloudwatch_policy" {
  name = "DatabricksCloudWatchAccess"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

// Attach EC2/EBS Policy to Cluster Deployment Role
resource "aws_iam_role_policy_attachment" "databricks_ec2_ebs_attach" {
  role       = aws_iam_role.databricks_cluster_deployment_iam.name
  policy_arn = aws_iam_policy.databricks_ec2_ebs_policy.arn
}

// Attach CloudWatch Policy to Cluster Deployment Role
resource "aws_iam_role_policy_attachment" "databricks_cloudwatch_attach" {
  role       = aws_iam_role.databricks_cluster_deployment_iam.name
  policy_arn = aws_iam_policy.databricks_cloudwatch_policy.arn
}

// Optional: Attach S3 Policy to Cluster Deployment Role
resource "aws_iam_role_policy_attachment" "databricks_s3_attach" {
  role       = aws_iam_role.databricks_cluster_deployment_iam.name
  policy_arn = aws_iam_policy.databricks_s3_limited_access.arn
}



