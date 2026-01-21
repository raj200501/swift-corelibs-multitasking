# Demo Guide

This demo runs entirely locally and is deterministic.

## Quick Demo (Default)
```bash
swift run multitasking-demo
```

## Demo Mode (Opt-in)
Demo mode runs extra instrumentation in a temporary directory and emits structured logs.

```bash
swift run multitasking-demo --demo
```

Or enable via environment variable:
```bash
MULTITASKING_DEMO=1 swift run multitasking-demo
```

## What You Should See
- Task output from the scheduler demo.
- Structured log lines indicating demo mode status.
- Timing metrics captured by `MetricsRegistry`.
- A health status log from `HealthChecker`.
