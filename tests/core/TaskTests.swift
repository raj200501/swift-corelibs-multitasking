import XCTest
@testable import Multitasking

final class TaskTests: XCTestCase {
    func testTaskExecution() {
        let expectation = self.expectation(description: "Task should be executed")
        let task = Task(name: "Test Task") {
            expectation.fulfill()
        }
        
        task.execute()
        
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(task.isTaskCompleted())
    }
    
    func testTaskCompletionStatus() {
        let task = Task(name: "Test Task") {}
        XCTAssertFalse(task.isTaskCompleted())
        task.execute()
        XCTAssertTrue(task.isTaskCompleted())
    }
}
