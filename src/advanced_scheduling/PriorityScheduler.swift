public class PriorityScheduler: TaskScheduler {
    public override func run() {
        tasksLock.lock()
        let tasksToRun = tasks.sorted(by: { $0.priority.rawValue > $1.priority.rawValue })
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
