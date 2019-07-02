terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::https://github.com/lsst-sqre/terraform-aws-ses.git//?ref=2.0.0"
  }
}

# keep `sort -u`d
aws_profile = "terragrunt-ts"
aws_region  = "us-west-2"
aws_zone_id = "Z1SYKSRAIWY86F"
dmarc_rua = "postmaster@ts.lsst.codes"
domain_name = "ts.lsst.codes"
from_address = ["postmaster@ts.lsst.codes"]
s3_bucket = "ts.lsst.codes-ses"
