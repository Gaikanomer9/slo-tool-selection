resource "sumologic_dashboard" "slg_tf_global-dashboard" {
    title            = "SLO overview"
    description      = "Panels for health of SLO configured across services"
    folder_id        = var.slo_dash_root_folder_id
    refresh_interval = 120
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

    ## search panel - log query
    panel {
        sumo_search_panel {
            key                                         = "search-panel-01"
            title                                       = "SLO List"
            description                                 = ""
            visual_settings                             = jsonencode(
            {
                "title" : {
                    "fontSize" : 14
                },
                "axes" : {
                    "axisX" : {
                        "titleFontSize" : 12,
                        "labelFontSize" : 12
                    },
                    "axisY" : {
                        "titleFontSize" : 12,
                        "labelFontSize" : 12
                    }
                },
                "series" : {},
                "general" : {
                    "type" : "table",
                    "displayType" : "default",
                    "paginationPageSize" : 100,
                    "fontSize" : 14,
                    "mode" : "distribution"
                },
                "legend" : {
                    "enabled" : false
                }
            }
            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_* | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") and ("{{tier}}"="*" or tier="{{tier}}")
| sum(sliceGoodCount) as GoodCount, sum(sliceTotalCount) as TotalCount by Service, SLOName
| (GoodCount/TotalCount)*100 as SLAVal
| order by SLAVal asc
| SLOName as ObjectiveName
| format("%.2f%%",SLAVal)  as Availability 
| fields  Service, ObjectiveName, Availability, GoodCount, TotalCount

QUERY
                query_type   = "Logs"
                query_key    = "A"
            }
            time_range {
                begin_bounded_time_range {
                    from {
                        relative_time_range {
                            relative_time = "-24h"
                        }
                    }
                }
            }
        }
    }
    ## search panel - log query
    panel {
        sumo_search_panel {
            key                                         = "search-panel-02"
            title                                       = "Daily Service Availability over last 7 days (Computed as Average of all SLO's configured for the given service)"
            description                                 = "Computed as Average of all SLO's configured for the given service"
            # stacked time series
            visual_settings                             = jsonencode(
            {
                "title" : {
                    "fontSize" : 14
                },
                "axes" : {
                    "axisX" : {
                        "title" : "Time",
                        "titleFontSize" : 12,
                        "labelFontSize" : 12
                    },
                    "axisY" : {
                        "title" : "AvgAvailability",
                        "titleFontSize" : 12,
                        "labelFontSize" : 12,
                        "logarithmic" : false,
                        "unit" : {
                            "value" : "%",
                            "isCustom" : false
                        }
                    },
                    "axisY2" : {
                        "unit" : {
                            "value" : "%",
                            "isCustom" : false
                        }
                    }
                },
                "legend" : {
                    "enabled" : true,
                    "verticalAlign" : "right",
                    "fontSize" : 12,
                    "maxHeight" : 50,
                    "showAsTable" : true,
                    "wrap" : true
                },
                "series" : {},
                "general" : {
                    "type" : "line",
                    "displayType" : "default",
                    "markerSize" : 10,
                    "lineDashType" : "solid",
                    "markerType" : "triangle",
                    "lineThickness" : 2,
                    "mode" : "timeSeries"
                },
                "color" : {
                    "family" : "Categorical Default"
                },
                "overrides" : [
                    {
                        "series" : [],
                        "queries" : [
                            "A"
                        ],
                        "properties" : {}
                    }
                ]
            }
            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_* | where ("{{Service}}"="*" or Service="{{Service}}") and ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") and ("{{tier}}"="*" or tier="{{tier}}")
| timeslice 1d
| sum(sliceGoodCount) as GoodReqs, sum(sliceTotalCount) as TotalReqs by _timeslice,Service, SLOName
| (GoodReqs/TotalReqs) as SLAVal
| avg(SLAVal)  as AvgAvailability by _timeslice,Service
| transpose row _timeslice column Service

QUERY
                query_type   = "Logs"
                query_key    = "A"
            }
            time_range {
                begin_bounded_time_range {
                    from {
                        relative_time_range {
                            relative_time = "-7d"
                        }
                    }
                }
            }
        }
    }

    ## layout
    layout {
        grid {
            layout_structure {
                key       = "search-panel-01"
                structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":0}"
            }
            layout_structure {
                key       = "search-panel-02"
                structure = "{\"height\":8,\"width\":24,\"x\":0,\"y\":8}"
            }
        }
    }

    
    ## variables
    variable {
        name               = "Service"
        display_name       = "Service"
        default_value      = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf*"
                field = "Service"
            }
        }
        allow_multi_select = true
        include_all_option = true
        hide_from_ui       = false
    }
    
    ## variables
    variable {
        name               = "deployment"
        display_name       = "deployment"
        default_value      = "*"
        source_definition {
            log_query_variable_source_definition {
                query = "_view=slogen_tf*"
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
                query = "_view=slogen_tf*"
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
                query = "_view=slogen_tf*"
                field = "tier"
            }
        }
        allow_multi_select = true
        include_all_option = true
        hide_from_ui       = false
    }
    
}
