TAGS ?= all
.PHONY: all
all:
	ansible-playbook --ask-vault-password -K -i inventory.yaml playbook.yaml --tags $(TAGS) --diff
