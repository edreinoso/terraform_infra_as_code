output "last_modified" {
    value = "${aws_lambda_function.lambda.last_modified}"
}

output "invoke" {
    value = "${aws_lambda_function.lambda.invoke_arn}"
}

output "arn" {
    value = "${aws_lambda_function.lambda.arn}"
}