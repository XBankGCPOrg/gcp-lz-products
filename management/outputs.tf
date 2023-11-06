output "folder_ids" {
  value = { for entry in module.folders.folder_id : keys(entry)[0] => values(entry)[0] }
}

output "project_ids" {
  value = {
    for entry in var.foundation_hierarchy.projects : entry.displayName => module.projects[entry.displayName].project_id
  }
}
output "lien_name" {
  value = {
    for entry in var.foundation_hierarchy.projects : entry.displayName => google_resource_manager_lien.lien[entry.displayName].name if entry.lienReason != null
  }
}

output "artifact_registry_name" {
  value = module.guardrails_artifact_registry.name
}

output "pub_sub_name" {
  value = [
    module.guardrails_pubsub_log_topic[keys(local.guardrails)[0]].name,
    module.guardrail_pubsub_topic_alerts.name
  ]
}

# output "guardrails_cloudfunction_name" {
#   value = module.guardrails_cloudfunction[keys(local.guardrails)[0]].google_cloudfunctions_function
# }
output "service_accounts" {
  value = {
    for entry in var.foundation_hierarchy.projects : entry.displayName => [for sa in local.service_accounts : module.service_accounts["${sa.name}@${sa.project}"].id]
  }
}
