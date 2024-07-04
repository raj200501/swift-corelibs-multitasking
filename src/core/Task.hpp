#ifndef TASK_HPP
#define TASK_HPP

#include <string>
#include <functional>
#include <ctime>

enum class TaskPriority {
    Low,
    Medium,
    High
};

class Task {
public:
    Task(const std::string &name, TaskPriority priority, std::time_t deadline, std::function<void()> work);
    void execute();
    bool isCompleted() const;
    void markAsCompleted();

private:
    std::string name;
    TaskPriority priority;
    std::time_t deadline;
    std::function<void()> work;
    bool completed;
};

#endif /* TASK_HPP */
