# Stand-in for google_project
resource "null_resource" "project" {
  provisioner "local-exec" {
    command = "echo ${var.developer} ${random_id.project_id.hex}"
  }
}

resource "random_id" "project_id" {
  prefix      = "xy-dev-"
  byte_length = 4
}
