terraform {
  backend "s3" {
    bucket         = "juldemo"
    key            = "demo/jul.tfstate"
    region         = "us-east-1"
    dynamodb_table = "demo-table"
  }
}

