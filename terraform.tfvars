terragrunt = {
  remote_state {
    backend = "s3"

    config {
      bucket         = "lsstsqre-tf-state-test"
      key            = "${path_relative_to_include()}/terraform.tfstate"
      region         = "us-west-2"
      encrypt        = true
      dynamodb_table = "lsstsqre-tf-lock-test"

      s3_bucket_tags {
        owner = "terragrunt integration test"
        name  = "Terraform state storage"
      }

      dynamodb_table_tags {
        owner = "terragrunt integration test"
        name  = "Terraform lock table"
      }
    }
  }

  terraform {
    # do not prompt for confirmation when running apply
    extra_arguments "auto_apply" {
      commands  = ["apply"]
      arguments = ["-auto-approve"]
    }
  }
}

google_project = "plasma-geode-127520"

aws_zone_id = "Z3TH0HRSNU67AM"

domain_name = "lsst.codes"
