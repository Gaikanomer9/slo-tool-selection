resource "sumologic_dashboard" "slg_tf_my-service-Overview" {
    title            = "Service Overview - my-service"
    description      = "Tracks all SLO's for service my-service"
    folder_id        = sumologic_folder.slg_tf_my-service.id
    refresh_interval = 300
    theme            = "Light"

    time_range {
        begin_bounded_time_range {
            from {
                literal_time_range {
                    range_name = "today"
                }
            }
        }
    }

    topology_label_map {
        data {
            label  = "service"
            values = ["my-service"]
        }
    }


    
    
## search panel - log query
    panel {
        sumo_search_panel {
            key                                         = "slo-minimal-name-gauge-today"
            title                                       = "Today's Availability"
            description                                 = "#good-requests / #requests since start of day"
            # stacked time series
            visual_settings                             = jsonencode(
            {
  "title": {
    "fontSize": 14
  },
  "general": {
    "type": "svp",
    "displayType": "default",
    "mode": "singleValueMetrics"
  },
  "svp": {
    "option": "Average",
    "label": "Availability (%)",
    "useBackgroundColor": false,
    "useNoData": false,
    "noDataString": "No data",
    "hideData": false,
    "hideLabel": false,
    "rounding": 2,
    "valueFontSize": 24,
    "labelFontSize": 14,
    "thresholds": [
      {
        "from": 0,
        "to": 98,
        "color": "#bf2121"
      },
      {
        "from": 98,
        "to": 99,
        "color": "#DFBE2E"
      },
      {
        "from": 99,
        "to": 100.1,
        "color": "#16943e"
      }
    ],
    "sparkline": {
      "show": false
    },
    "gauge": {
      "show": true
    }
  },
  "series": {}
}

            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") 
| sum(sliceGoodCount) as totalGood, sum(sliceTotalCount) as totalCount
| (totalGood/totalCount)*100 as SLO | format("%.2f%%",SLO) as sloStr
| fields SLO

QUERY
                query_type   = "Logs"
                query_key    = "A"
            }
            time_range {
                begin_bounded_time_range {
                    from {
                        
                        literal_time_range {
                            range_name = "today"
                        }
                        
                    }
                }
            }
        }
    }
    
## search panel - log query
    panel {
        sumo_search_panel {
            key                                         = "slo-minimal-name-gauge-week"
            title                                       = "Week's Availability"
            description                                 = "#good-requests / #requests since start of week"
            # stacked time series
            visual_settings                             = jsonencode(
            {
  "title": {
    "fontSize": 14
  },
  "general": {
    "type": "svp",
    "displayType": "default",
    "mode": "singleValueMetrics"
  },
  "svp": {
    "option": "Average",
    "label": "Availability (%)",
    "useBackgroundColor": false,
    "useNoData": false,
    "noDataString": "No data",
    "hideData": false,
    "hideLabel": false,
    "rounding": 2,
    "valueFontSize": 24,
    "labelFontSize": 14,
    "thresholds": [
      {
        "from": 0,
        "to": 98,
        "color": "#bf2121"
      },
      {
        "from": 98,
        "to": 99,
        "color": "#DFBE2E"
      },
      {
        "from": 99,
        "to": 100.1,
        "color": "#16943e"
      }
    ],
    "sparkline": {
      "show": false
    },
    "gauge": {
      "show": true
    }
  },
  "series": {}
}

            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") 
| sum(sliceGoodCount) as totalGood, sum(sliceTotalCount) as totalCount
| (totalGood/totalCount)*100 as SLO | format("%.2f%%",SLO) as sloStr
| fields SLO

QUERY
                query_type   = "Logs"
                query_key    = "A"
            }
            time_range {
                begin_bounded_time_range {
                    from {
                        
                        literal_time_range {
                            range_name = "week"
                        }
                        
                    }
                }
            }
        }
    }
    
## search panel - log query
    panel {
        sumo_search_panel {
            key                                         = "slo-minimal-name-gauge-month"
            title                                       = "Month's Availability"
            description                                 = "#good-requests / #requests since start of month"
            # stacked time series
            visual_settings                             = jsonencode(
            {
  "title": {
    "fontSize": 14
  },
  "general": {
    "type": "svp",
    "displayType": "default",
    "mode": "singleValueMetrics"
  },
  "svp": {
    "option": "Average",
    "label": "Availability (%)",
    "useBackgroundColor": false,
    "useNoData": false,
    "noDataString": "No data",
    "hideData": false,
    "hideLabel": false,
    "rounding": 2,
    "valueFontSize": 24,
    "labelFontSize": 14,
    "thresholds": [
      {
        "from": 0,
        "to": 98,
        "color": "#bf2121"
      },
      {
        "from": 98,
        "to": 99,
        "color": "#DFBE2E"
      },
      {
        "from": 99,
        "to": 100.1,
        "color": "#16943e"
      }
    ],
    "sparkline": {
      "show": false
    },
    "gauge": {
      "show": true
    }
  },
  "series": {}
}

            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") 
| sum(sliceGoodCount) as totalGood, sum(sliceTotalCount) as totalCount
| (totalGood/totalCount)*100 as SLO | format("%.2f%%",SLO) as sloStr
| fields SLO

QUERY
                query_type   = "Logs"
                query_key    = "A"
            }
            time_range {
                begin_bounded_time_range {
                    from {
                        
                        literal_time_range {
                            range_name = "month"
                        }
                        
                    }
                }
            }
        }
    }
    

    panel {

        text_panel {
            key                                         = "slo-minimal-name-text-overview"
            title                                       = "SLO Details"
            visual_settings                             = jsonencode({
                "general" : {
                    "mode" : "TextPanel",
                    "type" : "text",
                    "displayType" : "default"
                },
                "title" : {
                    "fontSize" : 14
                },
                "text" : {
                    "format" : "markdownV2",
                    "verticalAlignment" : "center",
                    "horizontalAlignment" : "center",
                    "textColor" : "#005982",
                    "fontSize" : 40,
                    "backgroundColor" : "#e4f5fa"
                },
                "series" : {},
                "legend" : {
                    "enabled" : false
                }
            })
            keep_visual_settings_consistent_with_parent = true
            text                                        = <<-EOF
##  slo-minimal-name

#### **`tier`**:*`0`*  
EOF
        }
    }
    

    ## layout
    layout {
        grid {
            
            layout_structure {
                key       = "slo-minimal-name-text-overview"
                structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":0}"
            }
            
            layout_structure {
                key       = "slo-minimal-name-gauge-today"
                structure = "{\"height\":6,\"width\":6,\"x\":6,\"y\":0}"
            }
            
            layout_structure {
                key       = "slo-minimal-name-gauge-week"
                structure = "{\"height\":6,\"width\":6,\"x\":12,\"y\":0}"
            }
            
            layout_structure {
                key       = "slo-minimal-name-gauge-month"
                structure = "{\"height\":6,\"width\":6,\"x\":18,\"y\":0}"
            }
            
        }
    }

    
    ## variables
    variable {
        name               = "deployment"
        display_name       = "deployment"
        default_value      = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf_* | where service= \"my-service\""
                field = "deployment"
            }
        }
        allow_multi_select = true
        include_all_option = true
        hide_from_ui       = false
    }
    
    ## variables
    variable {
        name               = "region"
        display_name       = "region"
        default_value      = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf_* | where service= \"my-service\""
                field = "region"
            }
        }
        allow_multi_select = true
        include_all_option = true
        hide_from_ui       = false
    }
    
    ## variables
    variable {
        name               = "tier"
        display_name       = "tier"
        default_value      = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf_* | where service= \"my-service\""
                field = "tier"
            }
        }
        allow_multi_select = true
        include_all_option = true
        hide_from_ui       = false
    }
    
}
