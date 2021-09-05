module "process_A_jobs" {
    for_each = fileset(path.module, "scripts/process_A/*.py")
    source = "./modules/glue_job"
    role = aws_iam_role.glue.arn
    bucket = aws_s3_bucket.scripts_bucket.id
    file = each.key 
}

output "process_A_jobs" {
    value = {
        for key, value in module.process_A_jobs : key => value.job_name
    }
}

# resource "aws_glue_workflow" "workflow_A" {
#     name = "glue_workflow_A"
# }

# resource "aws_glue_trigger" "workflow_A_all_jobs" {
#     name          = "workflow_A_all_jobs"
#     type          = "ON_DEMAND"
#     workflow_name = aws_glue_workflow.workflow_A.name

#     dynamic "actions" {
#         for_each = module.process_A_jobs
#         content {
#             job_name = actions.value["job_name"]
#         }
#     }
# }
