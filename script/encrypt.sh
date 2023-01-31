#!/bin/bash -ue

secret=$1

key=age18k877ypfdtn4rvpurx5c4ywwee89mzw7twx7hmjn5pem704zpqnqcqxm9f

if [[ -z "${secret}" ]]; then echo "Please specify secret"; exit 1; fi

yq -i "(del.sops)" ./k8s/secret/${secret}.yaml

yq -i ".data.${secret}=\"$(cat k8s/secret/${secret}.in.txt | base64 | sed -z 's/\n//g')\"" k8s/secret/${secret}.yaml

sops --encrypt \
	--age ${key} \
	--encrypted-regex '^(data|stringData)$$' \
	--in-place \
	k8s/secret/${secret}.yaml

yamlfmt k8s/secret/${secret}.yaml
