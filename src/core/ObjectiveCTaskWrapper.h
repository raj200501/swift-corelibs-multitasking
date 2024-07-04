#import <Foundation/Foundation.h>
#include "Task.hpp"

@interface ObjectiveCTaskWrapper : NSObject

@property (nonatomic, assign) Task *task;

- (instancetype)initWithTask:(Task *)task;
- (void)executeTask;
- (BOOL)isTaskCompleted;

@end
