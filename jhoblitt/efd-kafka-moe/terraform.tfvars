terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::https://github.com/jhoblitt/terraform-efd-kafka.git//?ref=master"

    extra_arguments "moar_faster" {
      commands = ["apply"]
      arguments = ["-parallelism=25"]
    }

    # set HELM_HOME to prevent sharing helm state between deployments
    extra_arguments "helm_vars" {
      commands = ["apply", "plan", "refresh", "destroy"]
      env_vars = {
        HELM_HOME = "${get_tfvars_dir()}/.helm"
      }
    }

    # helm requires manual init
    before_hook "1_helm_init" {
      commands = ["apply", "plan", "refresh", "destroy"]
      execute = [
        "helm", "init", "--home", "${get_tfvars_dir()}/.helm", "--client-only",
      ]
      run_on_error = false
    }

    # the helm.helm_repository resource DOES NOT handle the repo existing in
    # the tf state but not existing in the local helm repo config.
    before_hook "2_helm_repo_add" {
      commands = ["apply", "plan", "refresh", "destroy"]
      execute = [
        "helm", "repo", "add", "confluentinc",
        "https://raw.githubusercontent.com/lsst-sqre/cp-helm-charts/master",
      ]
      run_on_error = false
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

env_name = "jhoblitt-moe"
dns_enable = true
grafana_oauth_client_id = ""
grafana_oauth_client_secret = ""
grafana_oauth_team_ids = "1936535"
grafana_admin_user = ""
grafana_admin_pass = ""
