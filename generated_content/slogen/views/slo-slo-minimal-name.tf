resource "sumologic_scheduled_view" "slg_tf_slogen_tf_my_service_slo_minimal_name" {
    index_name       = "slogen_tf_my_service_slo_minimal_name"
    query            = <<QUERY
_sourceCategory=my-service | where api_path="/login" 
| timeslice 1m
| if ( (responseTime) < 500 and (statusCode matches /[2-3][0-9]{2}/ ), 1, 0) as isGood

| if(isNull(deployment),"dev",deployment) as deployment

| aws_region as region

| sum(isGood) as sliceGoodCount, count as sliceTotalCount 
  by _timeslice, deployment, region

| "slo-minimal-name" as SLOName 
| "my-service" as Service

| "0" as tier

QUERY
    start_time       = "2022-05-16T22:00:00Z"
    retention_period = "100"
    parsing_mode     = "AutoParse"
    lifecycle {
        prevent_destroy = "false"
    }
}
