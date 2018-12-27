terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    #source = "git::https://github.com/lsst-sqre/terraform-gitlfs.git/tf/?ref=master"
    source = "/home/jhoblitt/github/terraform-gitlfs/tf"

    # set HELM_HOME to prevent sharing helm state between deployments
    extra_arguments "helm_vars" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      env_vars = {
        HELM_HOME = "${get_tfvars_dir()}/.helm"
      }
    }

    before_hook "tf_plugins" {
      commands = ["init", "init-from-module"]

      run_on_error = false

      execute = [
        "make"
      ]
    }

    # helm requires manual init
    before_hook "helm_init" {
      commands = ["init", "init-from-module"]

      run_on_error = false

      execute = [
        "helm", "init", "--home", "${get_tfvars_dir()}/.helm", "--client-only",
      ]
    }

    extra_arguments "tls" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      env_vars = {
        # get_parent_tfvars_dir() is broken when used from a child .tfvars and
        # returns the child path instead of the parent
        # https://github.com/gruntwork-io/terragrunt/issues/332
        TF_VAR_tls_crt_path = "${get_parent_tfvars_dir()}/../../lsst-certs/lsst.codes/2018/lsst.codes_chain.pem"
        TF_VAR_tls_key_path = "${get_parent_tfvars_dir()}/../../lsst-certs/lsst.codes/2018/lsst.codes.key"
      }
    }
  } # terraform
}

env_name = "jhoblitt-test"
dns_enable = true
google_project = "plasma-geode-127520"
aws_zone_id = "Z3TH0HRSNU67AM"
domain_name = "lsst.codes"
