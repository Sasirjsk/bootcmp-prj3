variable "env_names" {
  description = "Set of environment names"
  type        = set(string)
  default     = ["dev", "stage", "prod"]
}

variable "env_details" {
  description = "Environment-specific metadata including slots"
  type = map(object({
    location     = string
    rg_name      = string
    plan_name    = string
    webapp_name  = string
    sku_name     = string
    slots        = list(string)
  }))
  default = {
    dev = {
      location     = "canadacentral"
      rg_name      = "rg-dev-ca"
      plan_name    = "asp-dev-ca"
      webapp_name  = "webapp-dev-ca"
      sku_name     = "P0v3"
      slots        = []
    }
    stage = {
      location     = "canadacentral"
      rg_name      = "rg-stage-ca"
      plan_name    = "asp-stage-ca"
      webapp_name  = "webapp-stage-ca"
      sku_name     = "P0v3"
      slots        = [stage]
    }
    prod = {
      location     = "canadacentral"
      rg_name      = "rg-prod-ca"
      plan_name    = "asp-prod-ca"
      webapp_name  = "webapp-prod-ca"
      sku_name     = "P0v3"
      slots        = [prod]  
    }
  }
}
