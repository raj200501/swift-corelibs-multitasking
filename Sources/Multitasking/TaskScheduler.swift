import Foundation

open class TaskScheduler {
    internal var tasks = [Task]()
    internal let queue = DispatchQueue(label: "com.multitasking.taskscheduler", attributes: .concurrent)
    internal let tasksLock = NSLock()

    public init() {}

    open func addTask(_ task: Task) {
        tasksLock.lock()
        tasks.append(task)
        tasksLock.unlock()
    }

    open func removeTask(_ task: Task) {
        tasksLock.lock()
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
        tasksLock.unlock()
    }

    open func run() {
        let tasksToRun = snapshotSorted(by: { $0.priority.rawValue > $1.priority.rawValue })
        executeConcurrently(tasksToRun)
    }

    open func runWithDeadline() {
        let tasksToRun = snapshotSorted(by: { ($0.deadline ?? Date.distantFuture).compare($1.deadline ?? Date.distantFuture) == .orderedAscending })
        executeConcurrently(tasksToRun)
    }

    open func runParallel(maxConcurrentTasks: Int) {
        let semaphore = DispatchSemaphore(value: maxConcurrentTasks)
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

    open func clearCompletedTasks() {
        tasksLock.lock()
        tasks.removeAll { $0.isTaskCompleted() }
        tasksLock.unlock()
    }

    // MARK: - Helpers for subclasses/tests

    public func snapshotTasks() -> [Task] {
        tasksLock.lock()
        let copy = tasks
        tasksLock.unlock()
        return copy
    }

    public func snapshotSorted(by areInIncreasingOrder: (Task, Task) -> Bool) -> [Task] {
        tasksLock.lock()
        let copy = tasks.sorted(by: areInIncreasingOrder)
        tasksLock.unlock()
        return copy
    }

    public func executeConcurrently(_ tasksToRun: [Task]) {
        let group = DispatchGroup()
        for task in tasksToRun {
            queue.async(group: group) {
                task.execute()
            }
        }
        group.wait()
    }
}
