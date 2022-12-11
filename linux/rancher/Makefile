.PHONY: lint dry-run

lint:
	helm lint --values ./values.test.yaml

template:
	helm template --values ./values.test.yaml . --debug
