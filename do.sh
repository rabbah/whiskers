#!/usr/bin/env bash

# The OpenWhisk CLI wsk must be in your path, override as needed
WSK=${WSK_CLI:-wsk}

function teardown() {
  rm -rf publish
  rm -rf config.yml

  $WSK action  delete whiskers/hello
  $WSK package delete whiskers
}

function deploy() {
  # deploy actions
  $WSK package update whiskers
  $WSK action  update whiskers/hello actions/hello.js -a web-export true
  WSKURL=`$WSK action get whiskers/hello --url | tail -1 | rev | cut -c16- | rev`
  echo ow: $WSKURL

  # build static content
  sed 's#$__OW_WEB_ACTIONS_BASE_PATH#'"${WSKURL}"'#g' config.template > config.yml
  jekyll build -c config.yml --source site --destination publish
}

function usage() {
  echo "Usage $@ [--deploy, --teardown]"
  echo   --deploy    build and deploy static content and functions
  echo   --teardown  deletes functions and removes static content locally
}

case "$1" in
--deploy )
deploy
;;
--teardown )
teardown
;;
* )
usage
esac





