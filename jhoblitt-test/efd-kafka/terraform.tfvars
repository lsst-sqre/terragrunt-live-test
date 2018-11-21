terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::git@github.com:jhoblitt/terraform-efd-kafka.git//?ref=plumbing/deploy"
  }
}

env_name = "jhoblitt-test"
