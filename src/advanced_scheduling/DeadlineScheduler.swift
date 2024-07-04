public class DeadlineScheduler: TaskScheduler {
    public override func run() {
        tasksLock.lock()
        let tasksToRun = tasks.sorted(by: { ($0.deadline ?? Date.distantFuture).compare($1.deadline ?? Date.distantFuture) == .orderedAscending })
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
