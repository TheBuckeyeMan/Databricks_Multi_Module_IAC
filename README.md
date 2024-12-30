# Databricks_AWS_Onboarding
Repo to onboard Databricks to AWS

# Manual Workspace Configuration
The steps below outline how to set up aws with existing aws s3 buckets

# Steps

1. Navigate to AWS and log in. Search for Databricks Data Intelligence Platform page in AWS Marketplace. -> Continue to Subscribe -> Subscribe

2. If you have not already signed up for databricks, create a databricks account

3. Click on create workspace -> Select Manual
   - Give your workspace a name for your project, select the same aws reion your resources are set up in
   - Select Region
   - Give Storage Config a name(Raw, Trusted, or Refined)(Raw recomended)
   - Add the bucket name of the Raw, Trusted, or Refined bucket(Raw recomended)
   - Add a placeholder IAM Role, you will update this later
   

3. Deploy the module databrickss3roles via terraform to get the nessasary IAM Roles created in AWS 
   - Modify the Bucket ARN's as needed to grant access to the required buckets.
   - Update the Service Principal for your databricks account and aws region


5. Click on Create Storage Configuration -> Give it the name of the level of medalian you are on(Raw, Trusted, Refined). i
   - Add Bucket name and IAM Role that alows access to AWS S3(Create one if you do not already have one)





# Quickstart Configuration
Follow Videos Here: https://www.databricks.com/resources/webinar/databricks-on-aws-free-training-series/thank-you?scid=7018Y000001Fi0MQAS&utm_source=google&utm_adgroup=141204956364&utm_offer=databricks-on-aws-free-training-series-track&utm_term=aws+databricks&gad_source=1&gbraid=0AAAAABYBeAhFuU2-ODMN7PPzake7Ny-Xj&gclid=CjwKCAiAg8S7BhATEiwAO2-R6mpX5Iix2s37psCDoDT7cxy6JarOudM077-LwE-NJ4TTmm7A06pXKRoC2PEQAvD_BwE
