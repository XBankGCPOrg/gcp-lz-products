output "workload_identity_provider" {
  value = [for sa in var.service_accounts.service_accounts : { service_account = module.service_account[sa.name].email, workload_identity_provider = google_iam_workload_identity_pool_provider.github[sa.name].name, gcs_state_bucket = module.individual_state_files[sa.tfstateBucketName].name }]
}
