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

@end
