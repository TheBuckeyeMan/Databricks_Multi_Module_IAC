# Databricks_AWS_Onboarding
Repo to onboard Databricks to AWS

# Manual Workspace Configuration
The steps below outline how to set up aws with existing aws s3 buckets

# Steps - Initial Workspace Setup

1. Navigate to AWS and log in. Search for Databricks Data Intelligence Platform page in AWS Marketplace. -> Continue to Subscribe -> Subscribe

2. If you have not already signed up for databricks, create a databricks account

3. Log into Databricks and Click on create workspace -> Select Quickstart
   - Give your workspace a name for your project, select the same aws reion your resources are set up in
   - Follow the pop up window to finish setup

4. In aws(The popup window) you will be brough to a template on CloudFormation. Add the folllowing
   - Edit the Stack name if you want
   - Do not add an IAM Role
   - Click Create Stack

5. At this point you will be redirected to a new page where you will see an event that is creating your Stack
   - This will take a few min but after it is created you will see the workspace in Databricks

# Add AWS S3 buckets to Databricks Workspace
   
1. Navigate to workspace: Navigate to your Databricks workspace, click on it. In the top right corner click Open Workspace

2. Verify you account has admin access: Click on your workspace name in top right corner and select manage account

3. Click on Users and Groups - Next to your name and email you should see Admin account
   - If you do not see admin account and need elivated, contact your workspace admin to elevate access if needed

4. Create Service Prinicpal(Or use Exusting): Selecr Service principals and click Add Service Prinicipal
   - Add a Service Principal(SP) name

5. Deploy AWS IAM Role: In databrickss3roles line 10 of main.tf we need to update the principal to include your Servuce Principal Name
   - Ex. AWS: "arn:aws:iam::YOUR_ACCOUNT_ID:role/service-role/YOUR_SERVICE_PRINCIPAL_NAME"

3. Deploy the module databrickss3roles via terraform to get the nessasary IAM Roles created in AWS 
   - Modify the Bucket ARN's as needed to grant access to the required buckets.
   - Update the Service Principal for your databricks account and aws region


5. Click on Create Storage Configuration -> Give it the name of the level of medalian you are on(Raw, Trusted, Refined). i
   - Add Bucket name and IAM Role that alows access to AWS S3(Create one if you do not already have one)





# Quickstart Configuration
Follow Videos Here: https://www.databricks.com/resources/webinar/databricks-on-aws-free-training-series/thank-you?scid=7018Y000001Fi0MQAS&utm_source=google&utm_adgroup=141204956364&utm_offer=databricks-on-aws-free-training-series-track&utm_term=aws+databricks&gad_source=1&gbraid=0AAAAABYBeAhFuU2-ODMN7PPzake7Ny-Xj&gclid=CjwKCAiAg8S7BhATEiwAO2-R6mpX5Iix2s37psCDoDT7cxy6JarOudM077-LwE-NJ4TTmm7A06pXKRoC2PEQAvD_BwE
