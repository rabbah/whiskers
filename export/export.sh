#!/bin/bash

export __OW_NAMESPACE=`wsk namespace get | tail -1`
export __OW_API_HOST="https://`wsk property get --apihost | cut -f 3`"
export __OW_API_KEY=`wsk property get --auth | cut -f 3`
export __OW_WEB_ACTIONS_BASE_PATH="${__OW_API_HOST}/api/v1/web/${__OW_NAMESPACE}"

# node export.js <package name> <action name> <content type> <content location>
# e.g.,
# node export.js whiskers       index         text/html      publish/index.html
# node export.js whiskers       css           text/css       publish/css/main.css

