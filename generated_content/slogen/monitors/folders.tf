
resource "sumologic_monitor_folder" "slg_tf_my-service" {
    name        = "my-service"
    description = "folder for SLO monitors for service : my-service"
    parent_id   = var.slo_mon_root_folder_id
}

