package compliance.policy.aws_iam.data_adapter

is_pwd_policy {
	input.subType == "aws-password-policy"
}

is_iam_user {
	input.subType == "aws-iam-user"
}

pwd_policy = policy {
    is_pwd_policy
	policy := input.resource
}

iam_user = user {
    is_iam_user
    user := input.resource
}
