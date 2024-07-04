import Multitasking

let advancedTask = Task(name: "Advanced Task", priority: .high) {
    print("Executing Advanced Task")
}

let scheduler = PriorityScheduler()
scheduler.addTask(advancedTask)
scheduler.run()
