#import "ObjectiveCTask.h"

@implementation ObjectiveCTask

- (instancetype)initWithName:(NSString *)name priority:(TaskPriority)priority deadline:(NSDate *)deadline work:(void (^)(void))work {
    self = [super init];
    if (self) {
        _name = name;
        _priority = priority;
        _deadline = deadline;
        _work = work;
        _completed = NO;
    }
    return self;
}

- (void)execute {
    if (self.work) {
        self.work();
        self.completed = YES;
    }
}

- (void)markAsCompleted {
    self.completed = YES;
}

@end
