#include "task.h"
#include <stdio.h>
#include <string.h>

Task *create_task(const char *name, TaskPriority priority, time_t deadline, void (*work)(void)) {
    Task *task = (Task *)malloc(sizeof(Task));
    task->name = strdup(name);
    task->priority = priority;
    task->deadline = deadline;
    task->work = work;
    task->is_completed = false;
    return task;
}

void execute_task(Task *task) {
    if (task && task->work) {
        task->work();
        task->is_completed = true;
    }
}

bool is_task_completed(const Task *task) {
    return task ? task->is_completed : false;
}

void mark_task_completed(Task *task) {
    if (task) {
        task->is_completed = true;
    }
}

void destroy_task(Task *task) {
    if (task) {
        free(task->name);
        free(task);
    }
}
