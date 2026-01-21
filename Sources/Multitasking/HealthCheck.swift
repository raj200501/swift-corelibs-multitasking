import Foundation

public struct HealthStatus {
    public let status: String
    public let timestamp: Date
    public let details: [String: String]
}

public final class HealthChecker {
    public typealias Check = () -> Bool

    private var checks: [String: Check] = [:]
    private let queue = DispatchQueue(label: "multitasking.health.checker")

    public init() {}

    public func registerCheck(name: String, check: @escaping Check) {
        queue.sync {
            checks[name] = check
        }
    }

    public func report() -> HealthStatus {
        let snapshot = queue.sync { checks }
        var details: [String: String] = [:]
        var status = "ok"

        for (name, check) in snapshot {
            let passed = check()
            details[name] = passed ? "ok" : "failed"
            if !passed {
                status = "degraded"
            }
        }

        return HealthStatus(status: status, timestamp: Date(), details: details)
    }
}
