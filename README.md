# Databricks AWS Onboarding
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

# Prepare S3 Buckets for Mounting
   
1. Navigate to workspace: Navigate to your Databricks workspace, click on it. In the top right corner click Open Workspace

2. Verify you account has admin access: Click on your workspace name in top right corner and select manage account

3. Click on Users and Groups - Next to your name and email you should see Admin account
   - If you do not see admin account and need elivated, contact your workspace admin to elevate access if needed

4. Create Service Prinicpal(Or use Existing): Selecr Service principals and click Add Service Prinicipal
   - Add a Service Principal(SP) name

5. Add Service Princial to Databricks Workspace: Navigate to your workspace, click on permissions, add permissions. Add your Service Principal(s) here

6. Deploy AWS IAM Role: In databrickss3roles line 10 of main.tf we need to update the following
   - Line 10 main.tf: Ex. "AWS": "arn:aws:iam::DATABRICKS_AWS_ACCOUNT_ID:root" --> this is NOT your normal AWS Account ID
   - ARN's of S3 Buckets we are looking at alow databricks to have access to
   - can remove multi-module.yml lines 56-57 if nessasary, we will add them back later if you do not have the values yet

7. Log into databricks, Before you click on your workspace, click on Cloud Resources -> Add Credential Configuration
   - Add a name Ex. Raw,Trusted,Refined Bucket Access
   - Add ARN of IAM Role we created in step 6

8. On the same page, click on the tag Storage Configuration. Add all the required S3 buckets with their ARN's that you granted databricks access when provisioning your IAM Roles(Step 6)

9. Your S3 buckets are ready to be mounted, before we mount, we must add a compute resource(cluster).

# Provisioning the Cluster

1. Generate PAT: Log into Databricks, click on your workspace. In the top right corner click on your icon and select settings -> developer -> Access Tokens -> Generate new Token
   - Add token to Environment Variables in Github Secrets named PAT
   - Update multi-module.yml lines 56-57 if they do not yet exist already

2. Get Host URL -> Log into your workspace, copy the url, Remove Queery Params:
   - Ex: https://dbc-b6fb6065-385e.cloud.databricks.com
   - Add to Github Secret named HOST
   - Update multi-module.yml lines 56-57 if they do not yet exist already

3. In databricks_cluster main.tf line 13 add in the IAM Role that was auto created when the databricks workspace was made. 
3. Provision the module databricks_cluster to deploy the cluster in the multi module repo
   - Check to make sure all Repo secrets are set up

# Mounting the S3 Buckets

9. Your Databricks Workspace Now has access to your S3 Buckets(Raw, Trusted, Refined)


# Cost Breakdown
Assumes 4 jobs per month 
Assumes storage fees are not involved





# Quickstart Configuration Videos
Follow Videos Here: https://www.databricks.com/resources/webinar/databricks-on-aws-free-training-series/thank-you?scid=7018Y000001Fi0MQAS&utm_source=google&utm_adgroup=141204956364&utm_offer=databricks-on-aws-free-training-series-track&utm_term=aws+databricks&gad_source=1&gbraid=0AAAAABYBeAhFuU2-ODMN7PPzake7Ny-Xj&gclid=CjwKCAiAg8S7BhATEiwAO2-R6mpX5Iix2s37psCDoDT7cxy6JarOudM077-LwE-NJ4TTmm7A06pXKRoC2PEQAvD_BwE


# How to remove Databricks Resources - To avoid control plan fixed costs. 
1. Delete the Databricks Workspace
The best way to avoid charges is to completely delete your Databricks workspace. This will eliminate both control plane fees and any potential compute or storage costs.

Steps to Delete the Workspace:

Log in to your AWS Management Console.
Go to CloudFormation.
Find the stack that created your Databricks workspace. It may be named something like:
databricks-<workspace-name>-workspace-stack
Select the stack and click Delete.
Confirm the deletion.
This will terminate the workspace and associated resources (e.g., default IAM roles and S3 buckets).

2. Terminate All Clusters
If you want to keep the workspace but ensure you’re not charged for compute:

Log in to your Databricks workspace.
Go to the Compute tab.
Terminate any running clusters.
Ensure there are no scheduled jobs that could start a cluster.
3. Delete or Empty Associated S3 Buckets
If your workspace was storing data in S3:

Log in to the AWS Management Console.
Go to S3.
Find the buckets associated with your workspace (e.g., databricks-youtube-dev-workspace-stack-08afe-bucket).
Delete the buckets or empty their contents to avoid storage charges.
4. Revoke IAM Roles
Remove any IAM roles associated with your Databricks workspace to prevent accidental resource access.

Steps:

Go to IAM → Roles in the AWS Console.
Find roles created for Databricks (e.g., databricks-youtube-dev-workspace-stack-08afe-role).
Detach policies and delete the roles.
5. Monitor AWS Billing
Check your AWS billing dashboard to ensure there are no unexpected charges:

Go to Billing → Bills in the AWS Console.
Review the Databricks and S3 sections for any active charges.
Set up a billing alarm to notify you of charges exceeding $1 (or another threshold):
Go to CloudWatch → Alarms → Create Alarm.
Select the Billing metric.
6. Cancel Databricks Subscription
If you subscribed to Databricks via the AWS Marketplace:

Go to AWS Marketplace → Subscriptions.
Locate the Databricks subscription and cancel it.
Confirming No Further Charges
After following these steps, you can verify that your AWS resources (S3 buckets, IAM roles, compute) are no longer active.
Databricks workspace charges should stop once the workspace is deleted.
Let me know if you need detailed help with any of these steps! 🚀