# Stand-in for google_project
resource "null_resource" "project" {
  for_each = local.developers

  provisioner "local-exec" {
    command = "echo ${each.value} ${random_id.project_id[each.value].hex}"
  }
}

resource "random_id" "project_id" {
  for_each    = local.developers
  prefix      = "xy-dev-"
  byte_length = 4
}
