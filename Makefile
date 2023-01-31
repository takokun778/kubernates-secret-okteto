include .secret.env
export

.PHONY: help
help: ## display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: tool
tool: ## Install tool
	@aqua i

.PHONY: ymlfmt
ymlfmt: ## YAML format
	@yamlfmt

.PHONY: key
key: ## key generate
	@age-keygen

.PHONY: secret
secret: ## Create kubernates secret yaml. ex) make secret secret=password
	@script/secret.sh ${secret}

.PHONY: encrypt
encrypt: ## Encrypt kubernates secret. ex) make encrypt secret=password
	@script/encrypt.sh ${secret}

.PHONY: decrypt
decrypt: ## Decrypt kubernates secret. ex) make decrypt secret=password
	@script/decrypt.sh ${secret}

.PHONY: sops
sops:
	@script/sops.sh ${secret}

.PHONY: tmp
tmp:
	@script/template.sh ${secret}

.PHONY: kapy
kapy:
	@(cd tmp && find . -name "*.yaml" | xargs -I {} kubectl apply -f {})

.PHONY: kdel
kdel:
	@(cd tmp && find . -name "*.yaml" | xargs -I {} kubectl delete -f {})
