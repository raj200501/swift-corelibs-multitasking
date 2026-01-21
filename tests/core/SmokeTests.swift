import XCTest
@testable import Multitasking

final class SmokeTests: XCTestCase {
    func testDemoWorkflowCompletesTasks() {
        let scheduler = PriorityScheduler()
        let monitor = PerformanceMonitor()

        let expectation = self.expectation(description: "Tasks run")
        expectation.expectedFulfillmentCount = 2

        let task1 = Task(name: "smoke-1", priority: .high) {
            expectation.fulfill()
        }
        let task2 = Task(name: "smoke-2", priority: .low) {
            expectation.fulfill()
        }

        scheduler.addTask(task1)
        scheduler.addTask(task2)

        monitor.startMonitoring()
        scheduler.run()
        _ = monitor.stopMonitoring()

        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(task1.isTaskCompleted())
        XCTAssertTrue(task2.isTaskCompleted())
    }
}
