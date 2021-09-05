resource "aws_s3_bucket_object" "glue_job_script" {
    bucket = var.bucket
    key    = var.file
    source = var.file
    etag = filemd5(var.file)
}
