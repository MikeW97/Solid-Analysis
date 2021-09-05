resource "aws_s3_bucket" "data_bucket" {
    bucket = "${var.environment}-data-${var.random}"
    acl    = "private"
}

resource "aws_glue_catalog_database" "use_case_name" {
    name = "use_case_name"
}

resource "aws_glue_crawler" "A_inventory" {
    database_name = aws_glue_catalog_database.use_case_name.name
    name          = "A_inventory"
    role          = aws_iam_role.glue.arn

    s3_target {
        path = "s3://prod-data-zpgbv/Inventory.csv"
    }
}

resource "aws_glue_crawler" "A_sales" {
    database_name = aws_glue_catalog_database.use_case_name.name
    name          = "A_sales"
    role          = aws_iam_role.glue.arn

    s3_target {
        path = "s3://prod-data-zpgbv/Sales.csv"
    }
}
