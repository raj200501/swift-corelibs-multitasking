import Foundation

public struct MetricsSummary {
    public let count: Int
    public let min: TimeInterval
    public let max: TimeInterval
    public let average: TimeInterval
}

public final class MetricsRegistry {
    private var timings: [String: [TimeInterval]] = [:]
    private let queue = DispatchQueue(label: "multitasking.metrics.registry")

    public init() {}

    public func recordTiming(name: String, duration: TimeInterval) {
        queue.sync {
            timings[name, default: []].append(duration)
        }
    }

    public func summary(for name: String) -> MetricsSummary? {
        return queue.sync {
            guard let values = timings[name], !values.isEmpty else {
                return nil
            }
            let count = values.count
            let minValue = values.min() ?? 0
            let maxValue = values.max() ?? 0
            let averageValue = values.reduce(0, +) / Double(count)
            return MetricsSummary(count: count, min: minValue, max: maxValue, average: averageValue)
        }
    }

    public func withTimer<T>(name: String, block: () throws -> T) rethrows -> T {
        let start = Date()
        let result = try block()
        let duration = Date().timeIntervalSince(start)
        recordTiming(name: name, duration: duration)
        return result
    }
}
