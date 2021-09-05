resource "aws_s3_bucket_object" "common_scripts" {
    bucket = aws_s3_bucket.scripts_bucket.id
    key    = "scripts/common/common.zip"
    source = "scripts/common/common.zip"
    etag = filemd5("scripts/common/common.zip")
}
