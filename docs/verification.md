# Verification
1. Set `trusted_principal_arn` to a controlled test role, and `target_bucket_arn` to a dedicated test bucket.
2. Assume the role using STS from the trusted principal.
3. Verify `aws s3 ls s3://YOUR_TEST_BUCKET/` works.
4. Verify access to a different bucket is denied.
5. Verify `PutObject` is denied in the target bucket.

Use IAM Policy Simulator or the AWS CLI with short-lived STS credentials. Do not create long-lived access keys for this lab.
