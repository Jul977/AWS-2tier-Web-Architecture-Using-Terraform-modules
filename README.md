# Two-tire architecture
Two-tier architecture, also known as client-server architecture, is a software design pattern that divides an application into two main parts or tiers: the client tier and the server tier. Each tier has specific responsibilities and interacts with each other to provide functionality to end-users.

## Local setup

We are going to use vs studio as a code editor. Download it from here [VsCode](https://code.visualstudio.com/) 

We are going to install Terraform extension in vs code. Download it from here [Terraform](https://developer.hashicorp.com/terraform/downloads) Make sure to restart your system after installation.


You need to install aws-cli to use the aws functionally from your terminal. Download it from here [Cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


### Create IAM Secret Key
Cretae an IAM user and attach a policy e.g AdministratorAccess
Create an Access key and secret key for the IAM user

### Create S3 Backend Bucket
Create an S3 bucket to store the .tfstate file in the remote backend
It is highly recommended that you enable Bucket Versioning on the S3 bucket to allow for state recovery in the case of accidental deletions and human error.

### Create a Dynamo DB table for state file locking
Give the table a name
Make sure to add a Partition key with the name LockID and type as String

### Generate a public-private key pair for our instances
We need a public key and a private key for our server so please follow the procedure I've included below.

cd modules/key/
ssh-keygen

### ACM certificate
Go to AWS console -> AWS Certificate Manager (ACM) and make sure you have a valid certificate in Issued status. if not, feel free to create one and use the domain name on which you are planning to host your application.

### Route 53 Hosted Zone
Go to AWS Console -> Route53 -> Hosted Zones and ensure you have a public hosted zone available, if not create one with the name of your domain.

### Configure AWS-CLI
Open the terminal on your system and type aws configure. it will ask for your Acess key ID and secret key id. Please enter what we have just created. Use the default region us-east-1 


## Write Terraform files
Finally, it's time to write your infrastructure.

## Now we are ready to deploy our application on the cloud

get into the project directory
cd main

👉 let install dependency to deploy the application
terraform init 

Type the below command to see the plan of the execution
terraform plan

✨Finally, HIT the below command to deploy the application...
terraform apply -auto-approve

## Outputs
let's see what Terraform created on our AWS console.

