#!/bin/bash -ue

secret=$1

cp k8s/secret/${secret}.yaml tmp/secret/${secret}.yaml

sops --decrypt --in-place tmp/secret/${secret}.yaml

yamlfmt tmp/secret/${secret}.yaml
