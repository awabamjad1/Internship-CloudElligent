data "archive_file" "dbtest" {
    type        = "zip"
    source_dir  = "dbtest"
    output_path = "dbtest.zip"
}