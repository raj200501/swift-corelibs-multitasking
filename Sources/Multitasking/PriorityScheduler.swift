import Foundation

public final class PriorityScheduler: TaskScheduler {
    public override func run() {
        let tasksToRun = snapshotSorted(by: { $0.priority.rawValue > $1.priority.rawValue })
        executeConcurrently(tasksToRun)
    }
}
