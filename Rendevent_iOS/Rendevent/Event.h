//
//  Event.h
//  Rendevent
//
//  Created by LiaoYangguang on 4/25/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, copy) NSString *descrip;
@property (nonatomic, copy) NSDate *startTime;
@property (nonatomic, copy) NSDate *endTime;

+ (id) initWithName:(NSString*)aName WithCategory:(NSInteger)aCategory WithDes:(NSString*)aDescription WithStartTime:(NSDate*)aStartTime WithEndTime:(NSDate*)aEndTime;

@end
