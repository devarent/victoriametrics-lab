#!/usr/bin/env bash
set -euo pipefail
curl -sS -X POST "http://localhost:8428/api/v1/import/prometheus" \
  --data-binary $'lab_cpu_usage{host="node-1"} 0.42\nlab_cpu_usage{host="node-2"} 0.71\n'
echo "waiting for the storage flush..."
sleep 10
