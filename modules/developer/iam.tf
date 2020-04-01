locals {
  # Stand-in for google_iam_policy
  project_iam_policy = jsonencode({
    foo = "serviceAccount:${null_resource.service_account.id}@bar.com"
  })
}

# Stand-in for google_project_iam_policy
resource "null_resource" "project_iam_policy" {
  provisioner "local-exec" {
    command = "echo ${null_resource.project.id} ${sha256(local.project_iam_policy)}"
  }
}
