resource "sumologic_dashboard" "slg_tf_my-service_slo-minimal-name" {
    title            = "SLO-SLO descriptive name"
    description      = "Tracks 98 objective: slo description to be added in dashboard text panel"
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
            key                                         = "gauge-today"
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
            key                                         = "gauge-week"
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
            key                                         = "gauge-month"
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
    
    ## search panel - log query
    panel {
        sumo_search_panel {
            key                                         = "hourly-burn-rate"
            title                                       = "Hourly Burn Rate"
            description                                 = "(ErrorsObserved)/(ErrorBudget) for the hour buckets where ErrorBudget = (1-SLO)*TotalRequests"
            # stacked time series
            visual_settings                             = jsonencode(
            {
    "axes": {
      "axisX": {
        "title": ""
      },
      "axisY": {
        "title": "hourlyBurnRate",
        "unit": {
          "isCustom": false,
          "value": "%"
        }
      }
    },
    "color": {
      "family": "Diverging 2"
    },
    "general": {
      "displayType": "default",
      "fillOpacity": 1,
      "mode": "timeSeries",
      "type": "column"
    },
    "series": {},
    "title": {
      "fontSize": 14
    },
    "overrides": [
      {
        "series": [
          "hourlyBurnRate"
        ],
        "queries": [],
        "properties": {
          "color": "#7959b3",
          "fillOpacity": 0.8,
          "name": "today"
        }
      },
      {
        "series": [
          "hourlyBurnRate_1d"
        ],
        "queries": [],
        "properties": {
          "color": "#4ea0bc",
          "fillOpacity": 0.7,
          "name": "today-24h"
        }
      }
    ]
  }

            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") 
| timeslice 60m 
| sum(sliceGoodCount) as tmGood, sum(sliceTotalCount) as tmCount  group by _timeslice
| tmGood/tmCount as tmSLO 
| (tmCount-tmGood) as tmBad 
| order by _timeslice asc
| total tmCount as totalCount  
| ((tmBad/tmCount)/(1-0.98)) as hourlyBurnRate
| fields _timeslice, hourlyBurnRate | compare timeshift 1d

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
            key                                         = "burn-trend"
            title                                       = "Burn rate trend compared to last 7 days  (upto current time of the day)"
            description                                 = "Today's burn rate (so far) along with last 7 days (till the same time as today)"
            # stacked time series
            visual_settings                             = jsonencode(
            {
  "title": {
    "fontSize": 14
  },
  "general": {
    "type": "honeyComb",
    "displayType": "default",
    "mode": "honeyComb"
  },
  "honeyComb": {
    "thresholds": [
     {
        "from": 0,
        "to": 50,
        "color": "#16943e"
      },
      {
        "from": 50,
        "to": 200,
        "color": "#ebc034"
      },
      {
        "from": 200,
        "to": 10000,
        "color": "#c40e20"
      }
    ],
    "shape": "hexagon",
    "groupBy": [],
    "aggregationType": "avg"
  },
  "series": {}
}

            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") 
| sum(sliceGoodCount) as totalGood, sum(sliceTotalCount) as totalCount 
| ((1 - totalGood/totalCount)/(1-0.98))*100 as BurnRate | fields BurnRate | compare timeshift 1d 7 
| fields BurnRate_7d,BurnRate_6d,BurnRate_5d,BurnRate_4d,BurnRate_3d,BurnRate_2d,BurnRate_1d,BurnRate

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
            key                                         = "budget-left"
            title                                       = "Budget remaining"
            description                                 = "Error budget from start of month"
            # stacked time series
            visual_settings                             = jsonencode(
            {
  "title": {
    "fontSize": 14
  },
  "axes": {
    "axisX": {
      "title": "",
      "titleFontSize": 12,
      "labelFontSize": 12
    },
    "axisY": {
      "title": "",
      "titleFontSize": 12,
      "labelFontSize": 12,
      "logarithmic": false,
      "unit": {
        "value": "%",
        "isCustom": false
      }
    }
  },
  "legend": {
    "enabled": true,
    "verticalAlign": "bottom",
    "fontSize": 12,
    "maxHeight": 50,
    "showAsTable": false,
    "wrap": true
  },
  "series": {},
  "general": {
    "type": "line",
    "displayType": "default",
    "markerSize": 5,
    "lineDashType": "solid",
    "markerType": "none",
    "lineThickness": 1,
    "mode": "timeSeries"
  },
  "color": {
    "family": "Categorical Default"
  },
  "overrides": [
    {
      "series": [
        "budgetRemaining_predicted"
      ],
      "queries": [],
      "properties": {
        "type": "line",
        "lineDashType": "dash",
        "lineThickness": 1.5,
        "color": "#50caf2",
        "name": "Forecasted Budget Remaining"
      }
    },
    {
      "series": [
        "budgetRemaining"
      ],
      "queries": [],
      "properties": {
        "type": "area",
        "lineThickness": 0,
        "color": "#f7995b",
        "name": "Budget Remaining"
      }
    }
  ]
}

            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") 
| timeslice 60m 
| sum(sliceGoodCount) as tmGood, sum(sliceTotalCount) as tmCount  group by _timeslice
| tmGood/tmCount as tmSLO 
| (tmCount-tmGood) as tmBad 
| order by _timeslice asc
| accum tmBad as runningBad  
| total tmCount as totalCount  
| totalCount*(1-0.98) as errorBudget
| (1-runningBad/errorBudget) as budgetRemaining 
| fields _timeslice, budgetRemaining
| predict budgetRemaining by 1h model=ar, forecast=800
| toLong(formatDate(_timeslice, "M")) as tmIndex 
| toLong(formatDate(now(), "M")) as monthIndex
| where  tmIndex = monthIndex | if(isNull(budgetRemaining),budgetRemaining_predicted,budgetRemaining) as budgetRemaining_predicted 
| fields _timeslice,budgetRemaining, budgetRemaining_predicted 

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
    
    ## search panel - log query
    panel {
        sumo_search_panel {
            key                                         = "breakdown"
            title                                       = "SLO Breakdown"
            description                                 = "reliability stats by fields specified in the config"
            # stacked time series
            visual_settings                             = jsonencode(
            {
  "axes": {
    "axisX": {
      "titleFontSize": 12,
      "labelFontSize": 12
    },
    "axisY": {
      "titleFontSize": 12,
      "labelFontSize": 12
    }
  },
  "series": {},
  "legend": {
    "enabled": false
  },
  "general": {
    "type": "table",
    "displayType": "default",
    "paginationPageSize": 100,
    "fontSize": 16,
    "mode": "distribution",
    "decimals": 2
  },
  "title": {
    "fontSize": 24
  }
}

            )
            keep_visual_settings_consistent_with_parent = true
            query {
                query_string = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name | where ("{{deployment}}"="*" or deployment="{{deployment}}") and ("{{region}}"="*" or region="{{region}}") 
| sum(sliceGoodCount) as totalGood, sum(sliceTotalCount) as totalCount by deployment,region  
| totalCount - totalGood as totalBad
| (totalGood/totalCount)*100 as Availability_Percentage
| totalCount*(1-0.98) as errorBudget
| (1-totalBad/errorBudget) as BudgetRemaining 
| BudgetRemaining*100 as %"Budget Remaining (%)"
| order by BudgetRemaining asc
| Availability_Percentage as %"Availability (%)" 
| fields  deployment,region,  %"Availability (%)", %"Budget Remaining (%)"

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
            key                                         = "text-panel-details"
            title                                       = "Details"
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
# Target
**98.00 %**

## slo description to be added in dashboard text panel

#### **`tier`**:*`0`*  
EOF
        }
    }

    panel {

        text_panel {
            key                                         = "text-panel-config"
            title                                       = "OpenSLO config"
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
                    "verticalAlignment" : "top",
                    "horizontalAlignment" : "left",
                    "textColor" : "#170546",
                    "fontSize" : 20,
                    "backgroundColor" : "#e4f5fa"
                },
                "series" : {},
                "legend" : {
                    "enabled" : false
                }
            })
            keep_visual_settings_consistent_with_parent = true
            text                                        = <<-EOF
``` yaml
apiVersion: openslo/v1alpha
kind: SLO
metadata:
    name: slo-minimal-name
    displayName: SLO descriptive name
spec:
    timeWindows: []
    budgetingMethod: Occurrences
    description: slo description to be added in dashboard text panel
    indicator: null
    service: my-service
    objectives:
        - displayName: delay less than 350
          value: 0
          ratioMetrics:
            good:
                source: sumologic
                queryType: Logs
                query: (responseTime) < 500 and (statusCode matches /[2-3][0-9]{2}/ )
            total:
                source: sumologic
                queryType: Logs
                query: _sourceCategory=my-service | where api_path="/login"
            incremental: true
          target: 0.98
labels:
    tier: "0"
fields:
    deployment: if(isNull(deployment),"dev",deployment)
    region: aws_region
alerts:
    burnRate:
        - shortWindow: 10m
          shortLimit: 14
          longWindow: 1h
          longLimit: 14
          notifications:
            - triggerFor:
                - Warning
                - ResolvedWarning
              connectionType: Email
              recipients:
                - youremailid@email.com
              timeZone: PST
            - triggerFor:
                - Critical
                - ResolvedCritical
              connectionType: PagerDuty
              connectionID: 1234abcd
            - triggerFor:
                - Critical
                - ResolvedCritical
              connectionType: Webhook
              connectionID: 0000000000ABC123

```
            EOF
        }
    }

    ## layout
    layout {
        grid {
            
            layout_structure {
                key       = "gauge-today"
                structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":0}"
            }
            
            layout_structure {
                key       = "gauge-week"
                structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":6}"
            }
            
            layout_structure {
                key       = "gauge-month"
                structure = "{\"height\":6,\"width\":6,\"x\":0,\"y\":12}"
            }
            
            layout_structure {
                key       = "hourly-burn-rate"
                structure = "{\"height\":6,\"width\":18,\"x\":6,\"y\":0}"
            }
            
            layout_structure {
                key       = "burn-trend"
                structure = "{\"height\":6,\"width\":18,\"x\":6,\"y\":6}"
            }
            
            layout_structure {
                key       = "budget-left"
                structure = "{\"height\":6,\"width\":18,\"x\":6,\"y\":12}"
            }
            
            layout_structure {
                key       = "text-panel-config"
                structure = "{\"height\":6,\"width\":12,\"x\":0,\"y\":18}"
            }
            
            layout_structure {
                key       = "text-panel-details"
                structure = "{\"height\":6,\"width\":12,\"x\":12,\"y\":18}"
            }
            
            layout_structure {
                key       = "breakdown"
                structure = "{\"height\":10,\"width\":24,\"x\":0,\"y\":24}"
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
                query = "_view=slogen_tf_my_service_slo_minimal_name"
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
                query = "_view=slogen_tf_my_service_slo_minimal_name"
                field = "region"
            }
        }
        allow_multi_select = true
        include_all_option = true
        hide_from_ui       = false
    }
    
}
