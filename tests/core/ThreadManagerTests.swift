import XCTest
@testable import Multitasking

final class ThreadManagerTests: XCTestCase {
    func testCreateThread() {
        let expectation = self.expectation(description: "Thread should execute work")
        ThreadManager.shared.createThread {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testJoinAllThreads() {
        let expectation1 = self.expectation(description: "Thread 1 should execute work")
        let expectation2 = self.expectation(description: "Thread 2 should execute work")

        ThreadManager.shared.createThread {
            expectation1.fulfill()
        }
        ThreadManager.shared.createThread {
            expectation2.fulfill()
        }

        ThreadManager.shared.joinAllThreads()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testTerminateAllThreads() {
        let expectation = self.expectation(description: "Thread should be terminated")
        expectation.isInverted = true

        ThreadManager.shared.createThread {
            expectation.fulfill()
        }
        
        ThreadManager.shared.terminateAllThreads()

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
