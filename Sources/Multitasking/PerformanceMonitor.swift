import Foundation

public final class PerformanceMonitor {
    private var startTime: Date?

    public init() {}

    public func startMonitoring() {
        startTime = Date()
    }

    public func stopMonitoring() -> TimeInterval? {
        guard let startTime = startTime else {
            return nil
        }
        let elapsedTime = Date().timeIntervalSince(startTime)
        return elapsedTime
    }

    public func logPerformance(taskName: String, duration: TimeInterval) {
        print("[PerformanceMonitor] Task '\(taskName)' completed in \(duration) seconds.")
    }
}
