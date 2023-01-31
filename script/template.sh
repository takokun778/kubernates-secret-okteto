#!/bin/bash -ue

secret=$1

export ENCODED_SECRET=$(echo "${SECRET}" | base64)

envsubst < k8s/secret/${secret}.yaml.template > tmp/secret/${secret}.yaml

yamlfmt tmp/secret/${secret}.yaml
