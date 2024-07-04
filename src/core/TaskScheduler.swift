import Foundation

public class TaskScheduler {
    private var tasks = [Task]()
    private let queue = DispatchQueue(label: "com.multitasking.taskscheduler", attributes: .concurrent)
    private var tasksLock = NSLock()

    public func addTask(_ task: Task) {
        tasksLock.lock()
        tasks.append(task)
        tasksLock.unlock()
    }

    public func removeTask(_ task: Task) {
        tasksLock.lock()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
        tasksLock.unlock()
    }

    public func run() {
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

    public func runWithDeadline() {
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

    public func runParallel(maxConcurrentTasks: Int) {
        let semaphore = DispatchSemaphore(value: maxConcurrentTasks)
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

    public func clearCompletedTasks() {
        tasksLock.lock()
        tasks.removeAll { $0.isTaskCompleted() }
        tasksLock.unlock()
    }
}
