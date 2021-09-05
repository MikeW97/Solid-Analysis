resource "aws_glue_job" "glue_job" {
    name     = var.file
    role_arn = var.role

    command {
        name = "glueetl"
        script_location = "s3://${var.bucket}/${aws_s3_bucket_object.glue_job_script.id}"
        python_version = "3"
    }

    depends_on = [
        aws_s3_bucket_object.glue_job_script
    ]
    timeout = "10"
    max_retries = "0"
    glue_version = "2.0"

    worker_type = "Standard"
    number_of_workers = "2"

    default_arguments = {
        "--TempDir" = "s3://${var.bucket}/temp/"
        "--enable-metrics" = ""
        "--job-language" = "python"
        "--job-bookmark-option" = "job-bookmark-disable"
        "--extra-py-files" = "s3://${var.bucket}/scripts/common/common.zip"
    }
}
