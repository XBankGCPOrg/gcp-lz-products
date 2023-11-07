output "registry_name" {
  value = { for entry in var.artifact_registry : "ar-${entry.project}-${entry.name}" => module.artifact_registry["ar-${entry.project}-${entry.name}"].name }
}