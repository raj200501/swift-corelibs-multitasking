import Foundation
import Multitasking

let scheduler = PriorityScheduler()
let monitor = PerformanceMonitor()

let task1 = Task(name: "Print hello", priority: .high) {
    print("[demo] Task 1: Hello from Multitasking")
}
let task2 = Task(name: "Print wait", priority: .medium) {
    Thread.sleep(forTimeInterval: 0.1)
    print("[demo] Task 2: Completed after short wait")
}
let task3 = Task(name: "Print goodbye", priority: .low) {
    print("[demo] Task 3: Goodbye!")
}

scheduler.addTask(task1)
scheduler.addTask(task2)
scheduler.addTask(task3)

monitor.startMonitoring()
scheduler.run()
if let duration = monitor.stopMonitoring() {
    monitor.logPerformance(taskName: "demo-run", duration: duration)
}

let demoModeEnabled = CommandLine.arguments.contains("--demo") || ProcessInfo.processInfo.environment["MULTITASKING_DEMO"] == "1"

if demoModeEnabled {
    let logger = StructuredLogger()
    let metrics = MetricsRegistry()
    let health = HealthChecker()
    let tracer = OpenTelemetryBridge()

    let tempDir = FileManager.default.temporaryDirectory.appendingPathComponent("multitasking-demo-\(UUID().uuidString)")
    do {
        try FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true, attributes: nil)
        let demoFile = tempDir.appendingPathComponent("demo.txt")
        try "demo mode active".write(to: demoFile, atomically: true, encoding: .utf8)
        logger.log(.info, message: "Demo mode enabled", metadata: ["temp_dir": tempDir.path])
    } catch {
        logger.log(.error, message: "Demo mode setup failed", metadata: ["error": "\(error)"])
    }

    health.registerCheck(name: "scheduler_ready") { true }
    let span = tracer.startSpan(name: "demo.execution", metadata: ["mode": "demo"])
    metrics.withTimer(name: "demo.step") {
        Thread.sleep(forTimeInterval: 0.01)
    }
    span.end()

    if let summary = metrics.summary(for: "demo.step") {
        logger.log(
            .info,
            message: "Demo timing metrics",
            metadata: [
                "count": "\(summary.count)",
                "min": "\(summary.min)",
                "max": "\(summary.max)",
                "avg": "\(summary.average)"
            ]
        )
    }

    let report = health.report()
    logger.log(.info, message: "Health status", metadata: ["status": report.status])
}
