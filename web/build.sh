#!/usr/bin/env bash

set -e

pushd ..
cp config.template config.yml
jekyll build -c config.yml --source site --destination web/publish
popd
