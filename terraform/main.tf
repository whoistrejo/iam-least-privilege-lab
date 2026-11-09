data "aws_iam_policy_document" "trust" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals { type = "AWS", identifiers = [var.trusted_principal_arn] }
  }
}
resource "aws_iam_role" "readonly" {
  name = "portfolio-s3-object-reader"
  assume_role_policy = data.aws_iam_policy_document.trust.json
  max_session_duration = 3600
}
data "aws_iam_policy_document" "read_objects" {
  statement {
    sid = "ListOnlyNamedBucket"
    effect = "Allow"
    actions = ["s3:ListBucket"]
    resources = [var.target_bucket_arn]
  }
  statement {
    sid = "ReadObjectsOnlyInNamedBucket"
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${var.target_bucket_arn}/*"]
  }
}
resource "aws_iam_policy" "read_objects" {
  name = "portfolio-s3-object-reader"
  policy = data.aws_iam_policy_document.read_objects.json
}
resource "aws_iam_role_policy_attachment" "readonly" {
  role = aws_iam_role.readonly.name
  policy_arn = aws_iam_policy.read_objects.arn
}
output "role_arn" { value = aws_iam_role.readonly.arn }
output "policy_arn" { value = aws_iam_policy.read_objects.arn }
