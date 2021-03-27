resource "aws_ssm_document" "docker_docuument" {
  name    = "docker_document"
  document_type = "Command"
  content = <<DOC
  {
    "schemaVersion": "1.2",
    "description": "Check running dockers.",
    "parameters": {

    },
    "runtimeConfig": {
      "aws:runShellScript": {
        "properties": [
          {
            "id": "0.aws:runShellScript",
            "runCommand": ["docker ps"]
          }
        ]
      }
    }
  }
DOC
}
