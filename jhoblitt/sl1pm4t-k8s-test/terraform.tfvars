terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::https://github.com/lsst-sqre/terraform-sl1pm4t-k8s-test.git//?ref=master"

    before_hook "1_tf_plugins" {
      commands = ["apply", "plan", "refresh", "destroy"]
      execute = [
        "make"
      ]
      run_on_error = false
    }
  } # terraform
}

env_name = "jhoblitt-moe"
