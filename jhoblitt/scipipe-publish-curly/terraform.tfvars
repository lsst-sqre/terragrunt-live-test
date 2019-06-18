terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::https://github.com/lsst-sqre/terraform-scipipe-publish.git//tf/?ref=3.0.0"

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

aws_zone_id = "Z3TH0HRSNU67AM"
dns_enable = true
domain_name = "lsst.codes"
env_name = "jhoblitt-curly"
#gke_version = "1.12"
google_project = "plasma-geode-127520"
google_region =  "us-central1"
google_zone = "us-central1-b"
grafana_oauth_team_ids = "1936535"
pkgroot_storage_size = "10Gi"
prometheus_oauth_github_org = "lsst-sqre"
