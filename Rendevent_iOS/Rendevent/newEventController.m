//
//  newEventController.m
//  Rendevent
//
//  Created by Jerry on 5/4/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "newEventController.h"
#import "Event.h"

@interface newEventController()

@property (strong, nonatomic) Event *newevent;

@end
@implementation newEventController
/*
 
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
 
 Event *event = [[Event alloc]init];
 event.name = aName;
 event.category = aCategory;
 event.descrip = aDescription;
 event.startTime = aStartTime;
 event.endTime = aEndTime;
 event.members = [NSMutableArray arrayWithCapacity:6];
*/

- (void)viewDidLoad
{
  self.newevent = [[Event alloc] init];
}
- (IBAction)inputName:(UITextField *)sender {
  self.newevent.name = sender.text;
}
- (IBAction)inputType:(UITextField *)sender {
  self.newevent.category = sender.text.integerValue;
}
- (IBAction)inputDescription:(UITextField *)sender {
  self.newevent.descrip = sender.text;
}
- (IBAction)inputStartTime:(UITextField *)sender {
  self.newevent.startTime = sender.text;
}

- (IBAction)inputMinMembers:(UITextField *)sender {
  self.newevent.minimum = sender.text.integerValue;
}
- (IBAction)inputMaxMembers:(UITextField *)sender {
  self.newevent.maximum = sender.text.integerValue;
}

- (IBAction)inputMinAge:(UITextField *)sender {
  self.newevent.mini_age = sender.text.integerValue;
}
- (IBAction)inputMaxAge:(UITextField *)sender {
  self.newevent.max_age = sender.text.integerValue;
}


@end
