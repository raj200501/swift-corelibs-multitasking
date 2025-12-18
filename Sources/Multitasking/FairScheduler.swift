import Foundation

public final class FairScheduler: TaskScheduler {
    public override func run() {
        let tasksToRun = snapshotTasks()
        executeConcurrently(tasksToRun)
    }
}
