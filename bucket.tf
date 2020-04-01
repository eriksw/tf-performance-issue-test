locals {
  buckets = [
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
  ]
}

# Stand-in for google_storage_bucket
resource "null_resource" "bucket" {
  for_each = {
    for pair in setproduct(local.developers, local.buckets) : "${pair[0]}__${pair[1]}" => {
      developer = pair[0]
      bucket    = pair[1]
    }
  }

  provisioner "local-exec" {
    command = "echo ${each.value.developer} ${each.value.bucket} ${random_id.bucket_name[each.key].hex} in project ${null_resource.project[each.value.developer].id}"
  }

  depends_on = [
    null_resource.project_service,
  ]
}

resource "random_id" "bucket_name" {
  for_each = {
    for pair in setproduct(local.developers, local.buckets) : "${pair[0]}__${pair[1]}" => {
      developer = pair[0]
      bucket    = pair[1]
    }
  }

  byte_length = 4
  prefix      = "${each.value.bucket}-"

  keepers = {
    developer = each.value.developer
    bucket    = each.value.bucket
  }
}
