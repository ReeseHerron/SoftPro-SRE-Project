# Monitor Group
resource "azurerm_monitor_action_group" "main" {
  name                = "sre-alerts"
  resource_group_name = var.rg_name
  short_name          = "SREAlerts"

  email_receiver {
    name                    = "send-to-reese"
    email_address           = var.email_address
    use_common_alert_schema = true
  }
}

# CPU Metric
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "webserver-cpu-alert"
  resource_group_name = var.rg_name
  scopes              = [var.vm_id] # This is passed in from the Compute module
  description         = "Action will be triggered when CPU exceeds 80%"
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}

# Availability Metric
resource "azurerm_monitor_metric_alert" "vm_availability" {
  name                = "webserver-availability-alert"
  resource_group_name = var.rg_name
  scopes              = [var.vm_id]
  description         = "Alert if the VM is down"
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "VmAvailabilityMetric"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
