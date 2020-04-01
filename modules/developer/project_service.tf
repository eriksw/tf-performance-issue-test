locals {
  services = toset([
    "cloudkms.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "storage-api.googleapis.com",
  ])
}

# Stand-in for google_project_service
resource "null_resource" "project_service" {
  for_each = local.services

  provisioner "local-exec" {
    command = "echo ${null_resource.project.id} ${each.value}"
  }
}
