import Multitasking

let task = Task(name: "Basic Task") {
    print("Executing Basic Task")
}

let scheduler = TaskScheduler()
scheduler.addTask(task)
scheduler.run()
