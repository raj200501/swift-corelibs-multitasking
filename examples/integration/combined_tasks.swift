import Multitasking

let task1 = Task(name: "Combined Task 1") {
    print("Executing Combined Task 1")
}

let task2 = Task(name: "Combined Task 2") {
    print("Executing Combined Task 2")
}

let scheduler = TaskScheduler()
scheduler.addTask(task1)
scheduler.addTask(task2)
scheduler.run()
