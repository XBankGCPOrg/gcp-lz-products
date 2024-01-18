module "firewall-rules" {
  source = "github.com/XBankGCPOrg/gcp-lz-modules//network/firewall-rules?ref=v2"
  #source                  = "../../gcp-lz-modules/network/firewall-rules"
  for_each                = { for entry in var.firewall-rules : entry.name => entry }
  depends_on              = [module.createsubnets]
  name                    = each.value.name
  description             = each.value.description
  direction               = each.value.direction
  disabled                = each.value.disabled
  network_name            = each.value.networkName
  project_id              = each.value.projectId
  source_ranges           = each.value.sourceRanges
  destination_ranges      = each.value.destinationRanges
  source_tags             = each.value.sourceTags
  source_service_accounts = each.value.sourceServiceAccounts
  target_tags             = each.value.targetTags
  target_service_accounts = each.value.targetServiceAccounts
  priority                = each.value.priority
  log_config              = each.value.logConfig
  allow                   = each.value.allow
  deny                    = each.value.deny
}
