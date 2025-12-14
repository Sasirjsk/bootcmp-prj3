terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.12.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "yoursubsciptionid"
}

provider "azuread" {}

# -----------------------------------------
# Resource Groups
# -----------------------------------------
resource "azurerm_resource_group" "rg" {
  for_each = toset(var.env_names)

  name     = var.env_details[each.value].rg_name
  location = var.env_details[each.value].location
}

# -----------------------------------------
# App Service Plans (Windows)
# -----------------------------------------
resource "azurerm_service_plan" "plan" {
  for_each = toset(var.env_names)

  name                = var.env_details[each.value].plan_name
  location            = azurerm_resource_group.rg[each.value].location
  resource_group_name = azurerm_resource_group.rg[each.value].name

  os_type  = "Windows"
  sku_name = var.env_details[each.value].sku_name
}

# -----------------------------------------
# Windows Web Apps
# -----------------------------------------
resource "azurerm_windows_web_app" "webapp" {
  for_each = toset(var.env_names)

  name                = var.env_details[each.value].webapp_name
  resource_group_name = azurerm_resource_group.rg[each.value].name
  location            = azurerm_resource_group.rg[each.value].location
  service_plan_id     = azurerm_service_plan.plan[each.value].id

  site_config {
    always_on = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
    }
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }
}

# ---------------------------------------------------------
# Flatten slot list (correct, valid)
# ---------------------------------------------------------
locals {
  slot_map = {
    for pair in flatten([
      for env, details in var.env_details : [
        for slot in details.slots : {
          key  = "${env}-${slot}"
          env  = env
          slot = slot
        }
      ]
    ]) :
    pair.key => {
      env  = pair.env
      slot = pair.slot
    }
  }
}

# -----------------------------------------
# Windows Web App Slots 
# -----------------------------------------
resource "azurerm_windows_web_app_slot" "slot" {
  for_each = local.slot_map

  name           = each.value.slot
  app_service_id = azurerm_windows_web_app.webapp[each.value.env].id

  site_config {
    always_on = true

    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
    }
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }
}
