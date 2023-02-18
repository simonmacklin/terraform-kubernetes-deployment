locals {

  labels = var.labels == null ? { app = var.name } : var.labels

  env = flatten([
    for name, value in var.env : {
      name  = tostring(name)
      value = tostring(value)
    }
  ])

  service_account_annotations = {}

  env_field = flatten([
    for name, field_path in var.env_field : {
      name       = tostring(name)
      field_path = tostring(field_path)
    }
  ])

  env_secret = flatten([
    for name, secret in var.env_secret : {
      name        = tostring(name)
      secret_key  = try(tostring(secret["key"]), name)
      secret_name = try(tostring(secret["name"]), secret)
    }
  ])
}