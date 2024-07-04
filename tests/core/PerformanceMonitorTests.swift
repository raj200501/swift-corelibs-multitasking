import XCTest
@testable import Multitasking

final class PerformanceMonitorTests: XCTestCase {
    func testPerformanceMonitoring() {
        let monitor = PerformanceMonitor()
        monitor.startMonitoring()
        let result = monitor.stopMonitoring()
        XCTAssertNotNil(result)
    }

    func testLogPerformance() {
        let monitor = PerformanceMonitor()
        monitor.startMonitoring()
        Thread.sleep(forTimeInterval: 0.5)
        if let duration = monitor.stopMonitoring() {
            monitor.logPerformance(taskName: "Test Task", duration: duration)
        }
    }
}
