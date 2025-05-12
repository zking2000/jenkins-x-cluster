FETCH_DIR := build/base
OUTPUT_DIR := config-root
KUBEAPPLY ?= kubectl apply
VAULT_ADDR ?= https://vault.jx-vault:8200

.PHONY: all
all: apply

.PHONY: apply
apply:
	jx gitops condition --last-commit-msg-prefix '!Merge pull request' -- make git-setup resolve-metadata
	jx gitops helmfile apply

.PHONY: resolve-metadata
resolve-metadata:
	jx gitops helmfile resolve

.PHONY: git-setup
git-setup:
	jx gitops git setup
	git pull

.PHONY: clean
clean:
	rm -rf build vendor
