#import "ObjectiveCTaskWrapper.h"

@implementation ObjectiveCTaskWrapper

- (instancetype)initWithTask:(Task *)task {
    self = [super init];
    if (self) {
        _task = task;
    }
    return self;
}

- (void)executeTask {
    if (_task) {
        _task->execute();
    }
}

- (BOOL)isTaskCompleted {
    return _task ? _task->isCompleted() : NO;
}

@end
