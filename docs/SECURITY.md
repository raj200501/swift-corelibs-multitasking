# Security

## Threat Model
The library focuses on concurrency primitives and local task scheduling. It does not provide network services by default.

Potential threats considered:
- **Denial of service** via unbounded task creation.
- **Resource exhaustion** via thread creation or long-running tasks.
- **Log leakage** if sensitive metadata is logged.

## Safe Defaults
- No network listeners or outbound connections are started by default.
- Observability utilities are opt-in. OpenTelemetry scaffolding is disabled unless `MULTITASKING_OTEL=1` is set.
- Demo mode uses a temporary directory and cleans up by process exit.

## Recommended Usage
- Limit task creation and apply backpressure where appropriate.
- Avoid logging secrets in metadata fields.
- Integrate `HealthChecker` and `MetricsRegistry` in server apps to surface internal state safely.

## Explicitly Out of Scope
- Authentication and authorization.
- Distributed tracing exporters (only scaffolding is provided).
- Network service hardening (left to application layer).
