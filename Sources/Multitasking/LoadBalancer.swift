import Foundation

public final class LoadBalancer: TaskScheduler {
    private let maxLoad: Int

    public init(maxLoad: Int) {
        self.maxLoad = maxLoad
        super.init()
    }

    public override func run() {
        let semaphore = DispatchSemaphore(value: maxLoad)
        let group = DispatchGroup()

        for task in snapshotTasks() {
            semaphore.wait()
            queue.async(group: group) {
                task.execute()
                semaphore.signal()
            }
        }

        group.wait()
    }
}
