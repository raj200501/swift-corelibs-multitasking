import Multitasking

let integrationTask = Task(name: "Integration Task") {
    print("Executing Integration Task")
}

let scheduler = TaskScheduler()
scheduler.addTask(integrationTask)
scheduler.run()
