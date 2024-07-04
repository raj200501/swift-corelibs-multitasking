#ifndef TASK_H
#define TASK_H

#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

typedef enum {
    LOW,
    MEDIUM,
    HIGH
} TaskPriority;

typedef struct {
    char *name;
    TaskPriority priority;
    time_t deadline;
    void (*work)(void);
    bool is_completed;
} Task;

Task *create_task(const char *name, TaskPriority priority, time_t deadline, void (*work)(void));
void execute_task(Task *task);
bool is_task_completed(const Task *task);
void mark_task_completed(Task *task);
void destroy_task(Task *task);

#endif /* TASK_H */
