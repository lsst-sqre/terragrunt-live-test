terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::https://github.com/lsst-sqre/terraform-scipipe-publish.git//tf/?ref=master"

    before_hook "make" {
      commands = ["init", "init-from-module"]

      run_on_error = false

      execute = [
        "bash", "-c", "cd ${get_tfvars_dir()}; make"
      ]
    }

    # set HELM_HOME to prevent sharing helm state between deployments
    extra_arguments "helm_vars" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      env_vars = {
        HELM_HOME = "${get_tfvars_dir()}/.helm"
      }
    }

    # helm requires manual init
    before_hook "1_helm_init" {
      commands = ["${get_terraform_commands_that_need_locking()}"]
      execute = [
        "helm", "init", "--home", "${get_tfvars_dir()}/.helm", "--client-only",
      ]
      run_on_error = false
    }

    before_hook "2_helm_update" {
      commands = ["init"]
      execute = [
        "helm", "repo", "--home", "${get_tfvars_dir()}/.helm", "update"
      ]
      run_on_error = false
    }
  } # terraform
}

dns_enable = true
env_name = "jhoblitt-curly"
pkgroot_storage_size = "100Gi"
google_zone = "us-central1-d"
