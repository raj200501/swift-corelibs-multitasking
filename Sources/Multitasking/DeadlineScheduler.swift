import Foundation

public final class DeadlineScheduler: TaskScheduler {
    public override func run() {
        let tasksToRun = snapshotSorted(by: { ($0.deadline ?? Date.distantFuture).compare($1.deadline ?? Date.distantFuture) == .orderedAscending })
        executeConcurrently(tasksToRun)
    }
}
