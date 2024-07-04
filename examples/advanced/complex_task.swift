import Multitasking

let complexTask = Task(name: "Complex Task", priority: .high, deadline: Date().addingTimeInterval(60)) {
    print("Executing Complex Task")
}

complexTask.execute()
