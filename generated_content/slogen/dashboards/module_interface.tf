terraform {
    required_providers {
        sumologic = {
            source = "sumologic/sumologic"
        }
    }
}



variable "slo_dash_root_folder_id" {
    type = string
}


