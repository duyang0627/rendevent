//
//  Event.m
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "Event.h"

@implementation Event

+(id)initWithName:(NSString *)aName WithCategory:(NSInteger)aCategory WithDes:(NSString *)aDescription WithStartTime:(NSDate *)aStartTime WithEndTime:(NSDate *)aEndTime {
    
    Event *event = [[Event alloc]init];
    event.name = aName;
    event.category = aCategory;
    event.descrip = aDescription;
    event.startTime = aStartTime;
    event.endTime = aEndTime;
    event.members = [NSMutableArray arrayWithCapacity:6];
    
    return event;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.category forKey:@"category"];
    [coder encodeInteger:self.event_Id forKey:@"event_Id"];
    [coder encodeObject:self.descrip forKey:@"descrip"];
    [coder encodeObject:self.startTime forKey:@"startTime"];
    [coder encodeObject:self.endTime forKey:@"endTime"];
    [coder encodeObject:self.members forKey:@"members"];
    [coder encodeInteger:self.minimum forKey:@"minimum"];
    [coder encodeInteger:self.maximum forKey:@"maximum"];
    [coder encodeInteger:self.mini_age forKey:@"mini_age"];
    [coder encodeInteger:self.max_age forKey:@"max_age"];
    [coder encodeInteger:self.host_Id forKey:@"max_age"];
    [coder encodeInteger:self.message_group_Id forKey:@"max_age"];
    [coder encodeObject:[NSNumber numberWithInteger:self.status] forKey:@"status"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.category = [coder decodeIntegerForKey:@"category"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.event_Id = [coder decodeIntegerForKey:@"event_Id"];
        self.descrip = [coder decodeObjectForKey:@"descrip"];
        self.startTime = [coder decodeObjectForKey:@"startTime"];
        self.endTime = [coder decodeObjectForKey:@"endTime"];
        self.members = [coder decodeObjectForKey:@"members"];
        self.minimum = [coder decodeIntegerForKey:@"minimum"];
        self.maximum = [coder decodeIntegerForKey:@"maximum"];
        self.mini_age = [coder decodeIntegerForKey:@"mini_age"];
        self.max_age = [coder decodeIntegerForKey:@"max_age"];
        self.host_Id = [coder decodeIntegerForKey:@"host_Id"];
        self.message_group_Id = [coder decodeIntegerForKey:@"message_group_Id"];
        self.status = [[coder decodeObjectForKey:@"status"] intValue];
    }
    return self;
}

@end
