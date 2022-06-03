
resource "sumologic_monitor" "slg_tf_my-service_slo-minimal-name-10m_1h" {
    name             = "slo-slo-minimal-name-10m_1h"
    description      = "slo description to be added in dashboard text panel"
    parent_id        = sumologic_monitor_folder.slg_tf_my-service.id
    type             = "MonitorsLibraryMonitor"
    is_disabled      = false
    content_type     = "Monitor"
    monitor_type     = "Logs"
    evaluation_delay = "5m"
    queries {
        row_id = "A"
        query  = <<QUERY
_view=slogen_tf_my_service_slo_minimal_name
| timeslice 10m 
| sum(sliceGoodCount) as tmGood, sum(sliceTotalCount) as tmCount  group by _timeslice
| fillmissing timeslice(1m)
| tmGood/tmCount as tmSLO 
| (tmCount-tmGood) as tmBad 
| total tmCount as totalCount
| totalCount*(1-0.98) as errorBudget
| if(tmCount>0,tmBad/tmCount,0) as errorRate
| (errorRate/(1-0.98)) as sliceBurnRate
| if(queryEndTime() - _timeslice <= 10m,sliceBurnRate, 0  )  as latestBurnRate 
| sum(tmGood) as totalGood, max(totalCount) as totalCount, max(latestBurnRate) as latestBurnRate 
| if(totalCount>0,totalGood/totalCount,0) as longErrorRate
| (1-longErrorRate)/(1-0.98) as longBurnRate
| if (longBurnRate > 14 , 1,0) as long_burn_exceeded
| if ( latestBurnRate > 14, 1,0) as short_burn_exceeded
| long_burn_exceeded + short_burn_exceeded as combined_burn

QUERY
    }
    trigger_conditions {
        logs_static_condition {
            field = "combined_burn"
            critical {
                time_range = "1h"
                alert {
                    threshold      = "2"
                    threshold_type = "GreaterThanOrEqual"
                }
                resolution {
                    threshold      = "2"
                    threshold_type = "LessThan"
                }
            }
            warning {
                time_range = "1h"
                alert {
                    threshold      = "1"
                    threshold_type = "GreaterThanOrEqual"
                }
                resolution {
                    threshold      = "1"
                    threshold_type = "LessThan"
                }
            }
        }
        logs_missing_data_condition {
            time_range = "30m"
        }
    }
    
    notifications {
        notification {
            connection_type = "Email"
            
            recipients      = [
                
                "youremailid@email.com",
                
            ]
            subject         = "SLO breach alert: my-service - slo-minimal-name"
            time_zone       = "PST"
            message_body    = "{{Description}} \n Result : {{ResultsJson}}\n Alert: {{AlertResponseURL}}"
            
        }
        run_for_trigger_types = [
            
            "Warning",
            "ResolvedWarning",
        ]
    }
    
    notifications {
        notification {
            connection_type = "PagerDuty"
            
            connection_id   = "1234abcd"
            
        }
        run_for_trigger_types = [
            
            "Critical",
            "ResolvedCritical",
        ]
    }
    
    notifications {
        notification {
            connection_type = "Webhook"
            
            connection_id   = "0000000000ABC123"
            
        }
        run_for_trigger_types = [
            
            "Critical",
            "ResolvedCritical",
        ]
    }
    
}

