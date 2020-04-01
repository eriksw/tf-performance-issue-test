/*
data "google_iam_policy" "project_iam_policy" {
  for_each = local.developers

  binding {
    role = "roles/owner"

    members = [
      "serviceAccount:${null_resource.service_account[each.value].id}@bar.com",
    ]
  }
}
*/

locals {
  # Stand-in for google_iam_policy
  project_iam_policy = { for n in local.developers : n => jsonencode({
    foo = "serviceAccount:${null_resource.service_account[n].id}@bar.com"
  }) }
}

# Stand-in for google_project_iam_policy
resource "null_resource" "project_iam_policy" {
  for_each = local.developers

  provisioner "local-exec" {
    command = "echo ${null_resource.project[each.value].id} ${sha256(local.project_iam_policy[each.value])}"
  }
}
