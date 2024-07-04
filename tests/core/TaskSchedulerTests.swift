import XCTest
@testable import Multitasking

final class TaskSchedulerTests: XCTestCase {
    func testAddTask() {
        let scheduler = TaskScheduler()
        let task = Task(name: "Test Task") {}
        scheduler.addTask(task)
        // Check internal state if accessible, or check indirectly through run behavior
    }

    func testRunTasks() {
        let scheduler = TaskScheduler()
        let expectation1 = self.expectation(description: "Task 1 should be executed")
        let expectation2 = self.expectation(description: "Task 2 should be executed")

        let task1 = Task(name: "Test Task 1") {
            expectation1.fulfill()
        }
        let task2 = Task(name: "Test Task 2") {
            expectation2.fulfill()
        }

        scheduler.addTask(task1)
        scheduler.addTask(task2)
        scheduler.run()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testRunWithDeadline() {
        let scheduler = TaskScheduler()
        let expectation1 = self.expectation(description: "Task 1 should be executed")
        let expectation2 = self.expectation(description: "Task 2 should be executed")
        
        let task1 = Task(name: "Test Task 1", deadline: Date().addingTimeInterval(1)) {
            expectation1.fulfill()
        }
        let task2 = Task(name: "Test Task 2", deadline: Date().addingTimeInterval(2)) {
            expectation2.fulfill()
        }

        scheduler.addTask(task1)
        scheduler.addTask(task2)
        scheduler.runWithDeadline()

        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
