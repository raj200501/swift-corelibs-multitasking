import Foundation

public enum StructuredLogLevel: String {
    case trace
    case debug
    case info
    case warn
    case error
}

public struct StructuredLogEvent {
    public let timestamp: Date
    public let level: StructuredLogLevel
    public let message: String
    public let metadata: [String: String]

    public init(timestamp: Date, level: StructuredLogLevel, message: String, metadata: [String: String]) {
        self.timestamp = timestamp
        self.level = level
        self.message = message
        self.metadata = metadata
    }

    public func formattedPlainText() -> String {
        let formatter = ISO8601DateFormatter()
        let timestampString = formatter.string(from: timestamp)
        let metadataString = metadata.keys.sorted().map { "\($0)=\(metadata[$0] ?? "")" }.joined(separator: " ")
        if metadataString.isEmpty {
            return "[\(timestampString)] \(level.rawValue.uppercased()): \(message)"
        }
        return "[\(timestampString)] \(level.rawValue.uppercased()): \(message) \(metadataString)"
    }

    public func formattedJSON() -> String? {
        let formatter = ISO8601DateFormatter()
        let payload: [String: Any] = [
            "timestamp": formatter.string(from: timestamp),
            "level": level.rawValue,
            "message": message,
            "metadata": metadata
        ]
        guard let data = try? JSONSerialization.data(withJSONObject: payload, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

public protocol StructuredLogSink {
    func write(event: StructuredLogEvent)
}

public final class ConsoleLogSink: StructuredLogSink {
    public init() {}

    public func write(event: StructuredLogEvent) {
        print(event.formattedPlainText())
    }
}

public final class StructuredLogger {
    private let sink: StructuredLogSink

    public init(sink: StructuredLogSink = ConsoleLogSink()) {
        self.sink = sink
    }

    public func log(_ level: StructuredLogLevel, message: String, metadata: [String: String] = [:]) {
        let event = StructuredLogEvent(timestamp: Date(), level: level, message: message, metadata: metadata)
        sink.write(event: event)
    }
}
