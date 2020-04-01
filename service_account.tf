# Stand-in for google_service_account
resource "null_resource" "service_account" {
  for_each = local.developers

  provisioner "local-exec" {
    command = "echo ${null_resource.project[each.value].id}"
  }
}
