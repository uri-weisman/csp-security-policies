package compliance.cis_aws.rules.cis_1_11

import data.cis_aws.test_data
import data.compliance.cis_aws.data_adapter
import data.lib.test

test_violation {
	eval_fail with input as rule_input([{"AccessKeyId": "test", "Active": true, "HasUsed": false}], null, true)
	eval_fail with input as rule_input([{"AccessKeyId": "test", "Active": true, "HasUsed": true}, {"AccessKeyId": "test", "Active": true, "HasUsed": false}], null, true)
}

test_pass {
	eval_pass with input as rule_input(null, null, false)
	eval_pass with input as rule_input(null, null, true)
	eval_pass with input as rule_input([], null, true)
	eval_pass with input as rule_input([{"AccessKeyId": "test", "Active": true, "HasUsed": true}], null, true)
	eval_pass with input as rule_input([{"AccessKeyId": "test", "Active": false, "HasUsed": true}], null, true)
}

test_not_evaluated {
	not_eval with input as test_data.not_evaluated_input
}

rule_input(access_keys, mfa_devices, has_logged_in) = test_data.generate_iam_user(access_keys, mfa_devices, has_logged_in)

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
