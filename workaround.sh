#!/bin/bash

set -e

export NIM_DISABLE_AUTOUPDATE=1

NIM=/opt/build/repo/.netlify/plugins/node_modules/nimbella-cli/bin/nim

NS=$($NIM auth current)
echo deploying web assets to $NS

$NIM project deploy . --exclude=packages
