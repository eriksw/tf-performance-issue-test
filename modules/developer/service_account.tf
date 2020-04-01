# Stand-in for google_service_account
resource "null_resource" "service_account" {
  provisioner "local-exec" {
    command = "echo ${null_resource.project.id}"
  }
}
