terraform {
    required_providers {
        sumologic = {
            source  = "sumologic/sumologic"
        }
    }
}
data "sumologic_personal_folder" "personalFolder" {}

resource "sumologic_folder" "slo_dash_root_folder" {
    name        = "slogen-tf-dashboards"
    description = "Your SLO dashboards created with slogen"
    parent_id   = data.sumologic_personal_folder.personalFolder.id
}

resource "sumologic_monitor_folder" "slo_mon_root_folder" {
    name        = "slogen-tf-monitors"
    description = "Root folder for SLO monitors created with slogen"
}

module "slg_tf_views" {
    source = "./views"
}

module "slg_tf_dashboards" {
    source                  = "./dashboards"
    slo_dash_root_folder_id = sumologic_folder.slo_dash_root_folder.id
    depends_on              = [module.slg_tf_views]
}

module "slg_tf_monitors" {
    source                 = "./monitors"
    slo_mon_root_folder_id = sumologic_monitor_folder.slo_mon_root_folder.id
    depends_on              = [module.slg_tf_views]
}
