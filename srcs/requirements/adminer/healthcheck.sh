#!/bin/sh

export REQUEST_METHOD="GET"
export SCRIPT_FILENAME="/status"
export SCRIPT_NAME="/status"

cgi-fcgi -bind -connect localhost:9000
