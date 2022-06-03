terraform {
    required_providers {
        sumologic = {
            source = "sumologic/sumologic"
        }
    }
}



variable "slo_mon_root_folder_id" {
    type = string
}


