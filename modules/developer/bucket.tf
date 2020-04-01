locals {
  buckets = toset([
    "aaron",
    "amparo",
    "arturo",
    "bill",
    "billy",
    "cathy",
    "charlene",
    "david",
    "elsie",
    "erica",
    "ernestine",
    "fannie",
    "frederic",
    "gary",
    "george",
    "gerald",
    "homer",
    "jaimie",
    "jay",
    "john",
    "joseph",
    "lynn",
    "maria",
    "matthew",
    "patricia",
    "patrick",
    "paula",
    "peggy",
    "philip",
    "roberta",
    "thomas",
  ])
}

# Stand-in for google_storage_bucket
resource "null_resource" "bucket" {
  for_each = local.buckets

  provisioner "local-exec" {
    command = "echo ${var.developer} ${each.value} ${random_id.bucket_name[each.key].hex} in project ${null_resource.project.id}"
  }

  depends_on = [
    null_resource.project_service,
  ]
}

resource "random_id" "bucket_name" {
  for_each = local.buckets

  byte_length = 4
  prefix      = "${each.value}-"

  keepers = {
    developer = var.developer
    bucket    = each.value
  }
}
