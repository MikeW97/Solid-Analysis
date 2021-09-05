resource "aws_s3_bucket" "scripts_bucket" {
    bucket = "${var.environment}-glue-scripts-${var.random}"
    acl    = "private"
}
