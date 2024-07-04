public class LoadBalancer: TaskScheduler {
    private var maxLoad: Int

    public init(maxLoad: Int) {
        self.maxLoad = maxLoad
    }

    public override func run() {
        let semaphore = DispatchSemaphore(value: maxLoad)
        let group = DispatchGroup()

        tasksLock.lock()
        let tasksToRun = tasks
        tasksLock.unlock()

        for task in tasksToRun {
            semaphore.wait()
            queue.async(group: group) {
                task.execute()
                semaphore.signal()
            }
        }

        group.wait()
    }
}
