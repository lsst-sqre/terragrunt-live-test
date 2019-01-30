terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    #source = "git::https://github.com/lsst-sqre/terraform-ses-test.git//?ref=master"
    source = "/home/jhoblitt/github/terraform-ses-test"
  }
}

s3_bucket = "jhoblitt-ses-test"
