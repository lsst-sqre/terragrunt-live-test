#!/bin/bash

die() {
  >&2 echo "$@"
  return 1
}

var_check() {
  local vars=(
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
  )
  for v in "${vars[@]}"; do
    if [[ ! -v ${v} ]]; then
      die "env var $v is required"
    fi
  done
}

bindir="${PWD}/bin"

if [[ ! -e $bindir ]]; then
  die "bin dir: ${bindir} not found; did you run \`make\`?"
fi

var_check
export PATH="${bindir}${PATH:+:${PATH}}"
