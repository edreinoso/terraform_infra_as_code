resource "aws_lambda_function" "lambda" {
  filename         = "${var.file-name}"
  function_name    = "${function-name}"
  role             = "${var.role}"
  handler          = "${var.handler}"
  source_code_hash = "${filebase64sha256("${var.file-name}")}"
  runtime          = "${var.runtime}"
  
  tags = {
    Name          = "${var.name}"
    Environment   = "${var.environment}"
    Template      = "${var.template}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
  }
}
