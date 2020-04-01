locals {
  configurations = { for name in local.developers : name => jsonencode({
    service_account = null_resource.service_account[name].id
    project         = null_resource.project[name].id
    signing_key     = null_resource.signing_key_version[name].id
    buckets = {
      for b in local.buckets : b => null_resource.bucket["${name}__${b}"].id
    }
  }) }
}

# Stand-in for google_storage_bucket_object
resource "null_resource" "configuration_file_output" {
  for_each = local.developers

  provisioner "local-exec" {
    command = "echo ${each.value} ${sha256(local.configurations[each.value])}"
  }
}
