# Stand-in for google_kms_key_ring
resource "null_resource" "key_ring" {
  for_each = local.developers

  provisioner "local-exec" {
    command = "echo ${null_resource.project[each.value].id}"
  }

  depends_on = [null_resource.project_service]
}

# Stand-in for google_kms_crypto_key
resource "null_resource" "signing_key" {
  for_each = local.developers

  provisioner "local-exec" {
    command = "echo ${null_resource.key_ring[each.value].id}"
  }
}

# Stand-in for data.google_kms_crypto_key_version
resource "null_resource" "signing_key_version" {
  for_each = local.developers

  provisioner "local-exec" {
    command = "echo ${null_resource.signing_key[each.value].id}"
  }
}