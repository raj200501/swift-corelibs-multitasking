import Foundation
import Multitasking

let scheduler = PriorityScheduler()
let monitor = PerformanceMonitor()

let task1 = Task(name: "Print hello", priority: .high) {
    print("[demo] Task 1: Hello from Multitasking")
}
let task2 = Task(name: "Print wait", priority: .medium) {
    Thread.sleep(forTimeInterval: 0.1)
    print("[demo] Task 2: Completed after short wait")
}
let task3 = Task(name: "Print goodbye", priority: .low) {
    print("[demo] Task 3: Goodbye!")
}

scheduler.addTask(task1)
scheduler.addTask(task2)
scheduler.addTask(task3)

monitor.startMonitoring()
scheduler.run()
if let duration = monitor.stopMonitoring() {
    monitor.logPerformance(taskName: "demo-run", duration: duration)
}
