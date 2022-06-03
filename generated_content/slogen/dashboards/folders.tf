
resource "sumologic_folder" "slg_tf_my-service" {
    name        = "my-service"
    description = "SLO dashboards for service my-service"
    parent_id   = var.slo_dash_root_folder_id
}

