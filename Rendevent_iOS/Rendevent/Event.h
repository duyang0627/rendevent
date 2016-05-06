//
//  Event.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject<NSCoding>

typedef enum : NSInteger {
    ParticipantNeeded,
    Ready,
    InProgress,
    Finished,
    Cancel
} EventStatus;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, assign) NSUInteger event_Id;
@property (nonatomic, copy) NSString *descrip;
@property (nonatomic, copy) NSDate *startTime;
@property (nonatomic, copy) NSDate *endTime;
@property (nonatomic, retain) NSMutableArray *members;
@property (nonatomic, assign) NSInteger minimum;
@property (nonatomic, assign) NSInteger maximum;
@property (nonatomic, assign) NSInteger mini_age;
@property (nonatomic, assign) NSInteger max_age;
@property (nonatomic, assign) NSUInteger host_Id;
@property (nonatomic, assign) NSUInteger message_group_Id;
@property (nonatomic, assign) EventStatus status;


+ (id) initWithName:(NSString*)aName WithCategory:(NSInteger)aCategory WithDes:(NSString*)aDescription WithStartTime:(NSDate*)aStartTime WithEndTime:(NSDate*)aEndTime;

@end
