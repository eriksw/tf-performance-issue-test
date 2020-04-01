locals {
  configuration = jsonencode({
    service_account = null_resource.service_account.id
    project         = null_resource.project.id
    signing_key     = null_resource.signing_key_version.id
    buckets = {
      for b in local.buckets : b => null_resource.bucket[b].id
    }
  })
}

# Stand-in for google_storage_bucket_object
resource "null_resource" "configuration_file_output" {
  provisioner "local-exec" {
    command = "echo ${var.developer} ${sha256(local.configuration)}"
  }
}
