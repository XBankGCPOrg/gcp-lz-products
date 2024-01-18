module "github-repo-create" {
  source          = "github.com/XBankGCPOrg/gcp-lz-modules//repo-creation?ref=v2"
  github_username = var.github_username
}