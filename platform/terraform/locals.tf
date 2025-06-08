locals {
  location_short = {
    "UK West"              = "ukw"
    "UK South"             = "uks"
    "West Europe"          = "we"
    "North Europe"         = "ne"
    "East US"              = "eus"
    "East US 2"            = "eus2"
    "Central US"           = "cus"
    "North Central US"     = "ncus"
    "South Central US"     = "scus"
    "West US"              = "wus"
    "West US 2"            = "wus2"
    "West US 3"            = "wus3"
    "Canada Central"       = "cac"
    "Canada East"          = "cae"
    "France Central"       = "frc"
    "France South"         = "frs"
    "Germany West Central" = "gwc"
    "Germany North"        = "gn"
    "Norway East"          = "noe"
    "Norway West"          = "now"
    "Sweden Central"       = "swc"
    "Switzerland North"    = "swn"
    "Switzerland West"     = "sww"
    "UAE North"            = "uaen"
    "UAE Central"          = "uaec"
    "Brazil South"         = "brs"
    "Japan East"           = "jpe"
    "Japan West"           = "jpw"
    "Australia East"       = "aue"
    "Australia Southeast"  = "ause"
    "Australia Central"    = "auc"
    "Southeast Asia"       = "sea"
    "East Asia"            = "eas"
    "Korea Central"        = "korc"
    "Korea South"          = "kors"
    "South Africa North"   = "san"
    "South Africa West"    = "saw"
    "India Central"        = "inc"
    "India West"           = "inw"
    "India South"          = "ins"
  }[var.location]

  env        = lower(var.environment_suffix)
  name_alias = lower(var.resource_name_alias)
  region     = lower(local.location_short)

  resource_group_name         = "${random_string.suffix.result}-${local.name_alias}-${local.env}-${local.region}-rg"
  key_vault_name              = substr(replace("${local.name_alias}${local.env}${local.region}kv${random_string.suffix.result}", "-", ""), 0, 24)  # <= 24 chars, no dashes
  storage_account_name        = substr(replace("${local.name_alias}${local.env}${local.region}stg${random_string.suffix.result}", "-", ""), 0, 24) # <= 24 chars, no dashes
  user_assigned_identity_name = "${random_string.suffix.result}-${local.name_alias}-${local.env}-${local.region}-mi"
  ai_services_name            = "${random_string.suffix.result}-${local.name_alias}-${local.env}-${local.region}-ais"
  ai_foundry_name             = "${random_string.suffix.result}-${local.name_alias}-${local.env}-${local.region}-aifnd"

  tags = merge(
    {
      "environment" = var.environment_suffix,
      "project"     = var.project_name,
      "location"    = var.location,
      "created_by"  = "terraform using identity ${data.azurerm_client_config.current.object_id}",
      "created_at"  = timestamp()
    },
    var.tags
  )
}