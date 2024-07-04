import Foundation

public enum TaskPriority: Int {
    case low = 0
    case medium
    case high
}

public class Task {
    public let id: UUID
    public let name: String
    public let work: () -> Void
    public let priority: TaskPriority
    public let deadline: Date?
    private var isCompleted: Bool

    public init(name: String, priority: TaskPriority = .medium, deadline: Date? = nil, work: @escaping () -> Void) {
        self.id = UUID()
        self.name = name
        self.priority = priority
        self.deadline = deadline
        self.work = work
        self.isCompleted = false
    }

    public func execute() {
        work()
        isCompleted = true
    }

    public func markAsCompleted() {
        isCompleted = true
    }

    public func isTaskCompleted() -> Bool {
        return isCompleted
    }
}
