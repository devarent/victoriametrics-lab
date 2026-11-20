#!/usr/bin/env bash
set -euo pipefail
END=$(date +%s)
START=$((END - 900))
curl -sS --get "http://localhost:8428/api/v1/query_range" \
  --data-urlencode 'query=avg(lab_cpu_usage)' \
  --data-urlencode "start=${START}" \
  --data-urlencode "end=${END}" \
  --data-urlencode 'step=60' \
| python -m json.tool
