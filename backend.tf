terraform {
  backend "s3" {
    bucket = "terraformbucket-2023"
    key    = "aws.tfstate"
    region = "ap-south-1"

  }
}