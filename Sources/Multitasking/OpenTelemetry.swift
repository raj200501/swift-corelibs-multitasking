import Foundation

public protocol TraceExporter {
    func exportSpan(name: String, start: Date, end: Date, metadata: [String: String])
}

public final class NoopTraceExporter: TraceExporter {
    public init() {}

    public func exportSpan(name: String, start: Date, end: Date, metadata: [String: String]) {
        _ = name
        _ = start
        _ = end
        _ = metadata
    }
}

public final class OpenTelemetryBridge {
    private let exporter: TraceExporter
    private let isEnabled: Bool

    public init(exporter: TraceExporter = NoopTraceExporter(), isEnabled: Bool = ProcessInfo.processInfo.environment["MULTITASKING_OTEL"] == "1") {
        self.exporter = exporter
        self.isEnabled = isEnabled
    }

    public func startSpan(name: String, metadata: [String: String] = [:]) -> OpenTelemetrySpan {
        guard isEnabled else {
            return OpenTelemetrySpan(name: name, start: Date(), exporter: nil, metadata: metadata)
        }
        return OpenTelemetrySpan(name: name, start: Date(), exporter: exporter, metadata: metadata)
    }
}

public final class OpenTelemetrySpan {
    private let name: String
    private let start: Date
    private let exporter: TraceExporter?
    private let metadata: [String: String]

    fileprivate init(name: String, start: Date, exporter: TraceExporter?, metadata: [String: String]) {
        self.name = name
        self.start = start
        self.exporter = exporter
        self.metadata = metadata
    }

    public func end() {
        let endTime = Date()
        exporter?.exportSpan(name: name, start: start, end: endTime, metadata: metadata)
    }
}
