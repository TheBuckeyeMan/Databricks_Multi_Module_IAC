resource "aws_iam_role" "databricks_s3_access" {
  name = "DatabricksS3Access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
            Service = "databricks.amazonaws.com"
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