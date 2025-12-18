import Foundation

extension Thread {
    func join(timeout: TimeInterval? = nil) {
        let deadline = timeout.map { Date().addingTimeInterval($0) }
        while !isFinished {
            if let deadline = deadline, Date() > deadline {
                break
            }
            Thread.sleep(forTimeInterval: 0.01)
        }
    }
}
