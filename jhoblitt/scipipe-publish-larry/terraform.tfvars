terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    #source = "git::https://github.com/lsst-sqre/terraform-scipipe-publish.git//tf/?ref=master"
    source = "/home/jhoblitt/github/terraform-scipipe-publish-larry/tf"

    extra_arguments "tls" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      env_vars = {
        # get_parent_tfvars_dir() is broken when used from a child .tfvars and
        # returns the child path instead of the parent
        # https://github.com/gruntwork-io/terragrunt/issues/332
        TF_VAR_tls_crt_path = "${get_parent_tfvars_dir()}/../../lsst-certs/lsst.codes/2018/lsst.codes_chain.pem"
        TF_VAR_tls_key_path = "${get_parent_tfvars_dir()}/../../lsst-certs/lsst.codes/2018/lsst.codes.key"
        TF_VAR_tls_dhparam_path = "${get_parent_tfvars_dir()}/dhparam.pem"
      }
    }
  } # terraform
}

env_name = "jhoblitt-larry"
pkgroot_storage_size = "100Gi"
