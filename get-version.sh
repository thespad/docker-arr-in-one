#! /bin/bash

APP_VERSION=$(date --iso-860);

printf "stable-%s" "${APP_VERSION}"
