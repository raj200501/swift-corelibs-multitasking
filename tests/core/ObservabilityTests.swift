import XCTest
@testable import Multitasking

final class ObservabilityTests: XCTestCase {
    final class CapturingSink: StructuredLogSink {
        private(set) var events: [StructuredLogEvent] = []

        func write(event: StructuredLogEvent) {
            events.append(event)
        }
    }

    func testStructuredLoggerCapturesMetadata() {
        let sink = CapturingSink()
        let logger = StructuredLogger(sink: sink)

        logger.log(.info, message: "hello", metadata: ["request_id": "abc123"])

        XCTAssertEqual(sink.events.count, 1)
        XCTAssertEqual(sink.events.first?.message, "hello")
        XCTAssertEqual(sink.events.first?.metadata["request_id"], "abc123")
    }

    func testStructuredLogFormattingIncludesMetadata() {
        let event = StructuredLogEvent(
            timestamp: Date(timeIntervalSince1970: 0),
            level: .debug,
            message: "formatted",
            metadata: ["component": "demo"]
        )

        let formatted = event.formattedPlainText()
        XCTAssertTrue(formatted.contains("DEBUG"))
        XCTAssertTrue(formatted.contains("component=demo"))
    }

    func testStructuredLogJSONFormatting() {
        let event = StructuredLogEvent(
            timestamp: Date(timeIntervalSince1970: 0),
            level: .info,
            message: "json",
            metadata: ["mode": "demo"]
        )

        let json = event.formattedJSON()
        XCTAssertNotNil(json)
        XCTAssertTrue(json?.contains("\"mode\":\"demo\"") ?? false)
    }

    func testMetricsRegistrySummary() {
        let metrics = MetricsRegistry()
        metrics.recordTiming(name: "unit", duration: 0.1)
        metrics.recordTiming(name: "unit", duration: 0.3)

        let summary = metrics.summary(for: "unit")
        XCTAssertEqual(summary?.count, 2)
        XCTAssertEqual(summary?.min, 0.1)
        XCTAssertEqual(summary?.max, 0.3)
    }

    func testMetricsRegistryTimerRecords() {
        let metrics = MetricsRegistry()
        _ = metrics.withTimer(name: "timer") {
            return "value"
        }

        let summary = metrics.summary(for: "timer")
        XCTAssertEqual(summary?.count, 1)
        XCTAssertNotNil(summary?.average)
    }

    func testHealthCheckerDefaultsToOk() {
        let checker = HealthChecker()
        let report = checker.report()
        XCTAssertEqual(report.status, "ok")
    }

    func testHealthCheckerReportsDegraded() {
        let checker = HealthChecker()
        checker.registerCheck(name: "dependency") { false }

        let report = checker.report()
        XCTAssertEqual(report.status, "degraded")
        XCTAssertEqual(report.details["dependency"], "failed")
    }
}
