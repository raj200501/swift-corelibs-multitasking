#include "Task.hpp"

Task::Task(const std::string &name, TaskPriority priority, std::time_t deadline, std::function<void()> work)
    : name(name), priority(priority), deadline(deadline), work(work), completed(false) {}

void Task::execute() {
    if (work) {
        work();
        completed = true;
    }
}

bool Task::isCompleted() const {
    return completed;
}

void Task::markAsCompleted() {
    completed = true;
}
