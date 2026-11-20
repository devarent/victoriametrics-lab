<div align="center">
<img src="assets/brand-logo.svg" alt="Arya Fatthurahman" width="120" />
</div>

# VictoriaMetrics Lab

<sub>Run VictoriaMetrics in Docker, import Prometheus metrics, and query them with PromQL and vmui.</sub>

<p>
  <img src="https://img.shields.io/badge/Database-VictoriaMetrics-621773?style=flat-square" alt="Database: VictoriaMetrics" />
  <img src="https://img.shields.io/badge/Category-Time--series%20database-6366F1?style=flat-square" alt="Category: Time-series database" />
  <img src="https://img.shields.io/badge/Runs%20in-Docker-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Runs in Docker" />
  <img src="https://img.shields.io/badge/License-MIT-22C55E?style=flat-square" alt="License: MIT" />
  <a href="https://github.com/devarent/victoriametrics-lab/actions/workflows/compose-check.yml"><img src="https://github.com/devarent/victoriametrics-lab/actions/workflows/compose-check.yml/badge.svg" alt="compose-check" /></a>
</p>

## What this lab is

VictoriaMetrics is a fast, low-footprint time-series database compatible with Prometheus metrics and PromQL. This lab starts the single-node server, imports sample metrics through the Prometheus ingestion endpoint, and queries them through the HTTP API and vmui.

## Quickstart

```bash
docker compose up -d
bash examples/01_import.sh
bash examples/02_query.sh
open http://localhost:8428/vmui
```

## Connection details

| Field | Value |
| --- | --- |
| Base URL | `http://localhost:8428` |
| vmui | `http://localhost:8428/vmui` |
| Import | `POST /api/v1/import/prometheus` |
| Query | `GET /api/v1/query?query=<PromQL>` |
| Retention | `1 day (lab setting)` |

## Examples

| File | What it shows |
| --- | --- |
| [`docker-compose.yml`](docker-compose.yml) | Engine, ports, and persistent volume. |
| [`.github/workflows/compose-check.yml`](.github/workflows/compose-check.yml) | Validates the Compose file on every push. |
| [`examples/01_import.sh`](examples/01_import.sh) | Import two Prometheus-style samples. |
| [`examples/02_query.sh`](examples/02_query.sh) | Run an instant PromQL query and pretty-print the JSON. |
| [`examples/03_range_query.sh`](examples/03_range_query.sh) | Run a range query over the last 15 minutes. |

## Exercises

1. Import a counter and use `rate()` over a range query.
2. Add a second label (`region`) and aggregate with `sum by (region)`.
3. Configure Prometheus to remote-write into VictoriaMetrics.
4. Compare `avg_over_time` and `avg` on the same series.

## Notes and limits

- This is the single-node VictoriaMetrics server, not the cluster version.
- Retention is set to one day so the lab volume stays small.
- VictoriaMetrics indexes imported samples asynchronously; `01_import.sh` waits ten seconds before the first query.
- `-search.latencyOffset=0` makes freshly imported samples visible immediately; production deployments often keep the default to avoid partial data.
- The import endpoint accepts the Prometheus text exposition format.
- PromQL compatibility is broad but not identical to Prometheus; check the upstream docs for edge cases.

## Run it from anywhere

This lab publishes its ports on `127.0.0.1` only. To use it from another country, do **not** open the database port to the internet. Pick one:

- **VPS + private tunnel:** run the lab on a small Ubuntu VPS, keep the port closed, and connect through WireGuard or `ssh -L`.
- **Managed service:** use a managed free tier for this engine and point the same examples at its connection string.
- **HTTP UI only:** if the engine has a web UI, put it behind Caddy with TLS and basic auth.

The shared checklist, provider map, and commands are in **[REMOTE-ACCESS.md](https://github.com/devarent/database-labs/blob/main/REMOTE-ACCESS.md)**.

## Cleanup

```bash
docker compose down -v
```

`-v` also removes the named volume, so the next start is a clean slate.

## References

- [VictoriaMetrics documentation](https://docs.victoriametrics.com/)
- [PromQL basics](https://docs.victoriametrics.com/metricsql/)
- [VictoriaMetrics Docker image](https://hub.docker.com/r/victoriametrics/victoria-metrics)

---

<sub>Part of the <a href="https://github.com/devarent/database-labs">database-labs</a> collection: 26 database engines, one index.</sub>

## License

MIT (c) 2026 Arya Fatthurahman. See [LICENSE](LICENSE).
