public class FairScheduler: TaskScheduler {
    public override func run() {
        // Implement fair scheduling logic
        tasksLock.lock()
        let tasksToRun = tasks
        tasksLock.unlock()

        let group = DispatchGroup()
        
        for task in tasksToRun {
            queue.async(group: group) {
                task.execute()
            }
        }
        
        group.wait()
    }
}
