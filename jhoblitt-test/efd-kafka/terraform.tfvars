terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::https://github.com/jhoblitt/terraform-efd-kafka.git//?ref=plumbing/deploy"

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
  }
}

env_name = "jhoblitt-test"
