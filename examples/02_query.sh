#!/usr/bin/env bash
set -euo pipefail
curl -sS --get "http://localhost:8428/api/v1/query" \
  --data-urlencode 'query=lab_cpu_usage' \
| python -m json.tool
