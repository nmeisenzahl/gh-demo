resource "azurerm_resource_group" "demo" {
  name     = "${var.prefix}-rg"
  location = var.locations
}

resource "azurerm_redis_cache" "demo" {
  name                = "${var.prefix}-redis"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
}

resource "azurerm_container_app_environment" "demo" {
  name                = "${var.prefix}-env"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_container_app" "app" {
  name                         = "${var.prefix}-app"
  container_app_environment_id = azurerm_container_app_environment.demo.id
  resource_group_name          = azurerm_resource_group.demo.name
  revision_mode                = "Single"

  template {
    container {
      name   = "app"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  # secret {
  #   name = "REDIS_CONNECTION_STRING"
  #   value = "test123-redis.redis.cache.windows.net:6380,password=072CEjEl0npD1IOU3FZ1wN5pvy9J2w7YuAzCaFupliW=,ssl=True,abortConnect=False"
  # }
}
