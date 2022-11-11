#!/bin/sh
# environment variables that are used by makefile
# do not use $ or tabs or " as they are expanded by make
# using insecure to allow retrieval from svl-artifactory
# can be sourced directly as follows
#
# $ export $(grep -v '^#' .env.sh | xargs)
#

GOPROXY=
GONOPROXY=
GONOSUMDB=