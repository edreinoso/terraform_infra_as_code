resource "aws_lambda_function" "lambda" {
  filename         = "${var.file-name}"
  function_name    = "${var.function-name}"
  role             = "${var.role}"
  handler          = "${var.handler}"
  source_code_hash = "${filebase64sha256("${var.file-name}")}"
  runtime          = "${var.runtime}"
  timeout          = "${var.timeout}"
  memory_size      = "${var.memory-size}"

  tags = {
    Name          = "${var.function-name}"
    Environment   = "${var.environment}"
    Template      = "${var.template}"
    Application   = "${var.application}"
    Purpose       = "${var.purpose}"
    Creation_Date = "${var.created-on}"
  }
}
