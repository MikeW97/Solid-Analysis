module "process_B_jobs" {
    for_each = fileset(path.module, "scripts/process_B/*.py")
    source = "./modules/glue_job"
    role = aws_iam_role.glue.arn
    bucket = aws_s3_bucket.scripts_bucket.id
    file = each.key 
}

output "process_B_jobs" {
    value = {
        for key, value in module.process_B_jobs : key => value.job_name
    }
}

# resource "aws_glue_workflow" "workflow_B" {
#     name = "glue_workflow_B"
# }

# resource "aws_glue_trigger" "workflow_B_all_jobs" {
#     name          = "workflow_B_all_jobs"
#     type          = "ON_DEMAND"
#     workflow_name = aws_glue_workflow.workflow_B.name

#     dynamic "actions" {
#         for_each = module.process_B_jobs
#         content {
#             job_name = actions.value["job_name"]
#         }
#     }
# }
