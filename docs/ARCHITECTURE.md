# Architecture

## Overview
`swift-corelibs-multitasking` is a Swift Package that provides scheduling, task orchestration, and lightweight observability utilities. The library is modular so applications can adopt the pieces they need without changing default behavior.

## Components
- **Schedulers**: `FairScheduler`, `PriorityScheduler`, and `DeadlineScheduler` coordinate task execution strategies.
- **Threading**: `ThreadManager` and thread helpers provide controlled thread creation and joining.
- **Tasks**: `Task` is the core unit of work with lifecycle helpers.
- **Observability (opt-in)**:
  - `StructuredLogger` for consistent, structured log output.
  - `MetricsRegistry` for in-process timing metrics.
  - `OpenTelemetryBridge` scaffolding (no exporters by default).
- **Health**: `HealthChecker` provides a lightweight health report for integration with servers.

## Data Flow
```text
Caller
  │
  ├─> Task / Scheduler APIs
  │     └─> ThreadManager
  │           └─> Thread execution
  │
  ├─> PerformanceMonitor (existing)
  └─> Observability (opt-in)
        ├─> StructuredLogger
        ├─> MetricsRegistry
        └─> OpenTelemetryBridge (disabled by default)
```

## Design Principles
- **Additive by default**: New features are opt-in and do not change existing behavior.
- **No external services required**: Observability utilities operate in-process and offline.
- **Composable**: Applications can stitch together schedulers, tasks, and observability as needed.
