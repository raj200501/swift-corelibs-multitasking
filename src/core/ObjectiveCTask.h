#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TaskPriority) {
    TaskPriorityLow,
    TaskPriorityMedium,
    TaskPriorityHigh
};

@interface ObjectiveCTask : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) TaskPriority priority;
@property (nonatomic, strong) NSDate *deadline;
@property (nonatomic, copy) void (^work)(void);
@property (nonatomic, assign, getter=isCompleted) BOOL completed;

- (instancetype)initWithName:(NSString *)name priority:(TaskPriority)priority deadline:(NSDate *)deadline work:(void (^)(void))work;
- (void)execute;
- (void)markAsCompleted;

@end
