terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    #source = "git::https://github.com/lsst-sqre/deploy-jenkins.git//tf/?ref=1.0.0"
    source = "/home/jhoblitt/github/deploy-jenkins-curly/tf"

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
dns_enable = "true"
domain_name = "lsst.codes"
env_name = "jhoblitt-moe"
group_name = "dm"
grafana_oauth_team_ids = "1936535"
jenkins_agent_executors = "1"
jenkins_agent_replicas = "1"
jenkins_agent_volume_size = "100Gi"
#master_fqdn = ""
prometheus_github_org = "lsst-sqre"
