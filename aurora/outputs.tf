# OUTPUT
// aws_rds_cluster
output  "rds_cluster_arn" {
  value = module.aurora.this_rds_cluster_arn
}
output  "rds_cluster_database_name" {
  value = module.aurora.this_rds_cluster_database_name
}
output  "rds_cluster_endpoint" {
  value = module.aurora.this_rds_cluster_endpoint
}
output  "rds_cluster_id" {
  value = module.aurora.this_rds_cluster_id
}
output  "rds_cluster_instance_endpoints" {
  value = module.aurora.this_rds_cluster_instance_endpoints
}
output  "rds_cluster_master_username" {
  value = module.aurora.this_rds_cluster_master_username
}
output  "rds_cluster_master_password" {
  value = module.aurora.this_rds_cluster_master_password
}