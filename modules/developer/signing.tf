# Stand-in for google_kms_key_ring
resource "null_resource" "key_ring" {
  provisioner "local-exec" {
    command = "echo ${null_resource.project.id}"
  }

  depends_on = [
    null_resource.project_service,
  ]
}

# Stand-in for google_kms_crypto_key
resource "null_resource" "signing_key" {

  provisioner "local-exec" {
    command = "echo ${null_resource.key_ring.id}"
  }
}

# Stand-in for data.google_kms_crypto_key_version
resource "null_resource" "signing_key_version" {

  provisioner "local-exec" {
    command = "echo ${null_resource.signing_key.id}"
  }
}