locals {
  services = [
    "cloudkms.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "storage-api.googleapis.com",
  ]
}

# Stand-in for google_project_service
resource "null_resource" "project_service" {
  for_each = {
    for pair in setproduct(local.developers, local.services) : "${pair[0]}__${pair[1]}" => {
      developer = pair[0]
      service   = pair[1]
    }
  }

  provisioner "local-exec" {
    command = "echo ${null_resource.project[each.value.developer].id} ${each.value.service}"
  }
}
