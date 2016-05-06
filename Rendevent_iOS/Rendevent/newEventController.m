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
//
//@property (strong, nonatomic) Event *newevent;
//@property (weak, nonatomic) IBOutlet UITextField *namefield;
//@property (weak, nonatomic) IBOutlet UITextField *typeField;
//@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
//@property (weak, nonatomic) IBOutlet UIDatePicker *endTimePicker;
//
//
//@property (weak, nonatomic) IBOutlet UITextField *minNumberField;
//@property (weak, nonatomic) IBOutlet UITextField *maxNumberField;
//@property (weak, nonatomic) IBOutlet UITextField *minAgeField;
//@property (weak, nonatomic) IBOutlet UITextField *maxAgeField;
//@property (weak, nonatomic) IBOutlet UITextField *desField;

@end
@implementation newEventController

- (void)viewDidLoad
{
  self.newevent = [[Event alloc] init];
  UIDatePicker *datePicker = [[UIDatePicker alloc] init];
  datePicker.datePickerMode = UIDatePickerModeDateAndTime;
  [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
  NSTimeZone *timeZone=[NSTimeZone localTimeZone];
  [datePicker setTimeZone:timeZone];
  self.startTimeField.inputView = datePicker;
  self.endTimeField.inputView = datePicker;
}

- (IBAction)dateChanged:(id)sender
{
  UIDatePicker *picker = (UIDatePicker *)sender;
  if ([self.startTimeField isFirstResponder])
  {
    self.startTimeField.text = [NSString stringWithFormat:@"%@", picker.date];
    self.newevent.startTime = picker.date;
    NSLog(@"start time is %@", self.newevent.startTime);
    
  }
  if ([self.endTimeField isFirstResponder]) {
    self.endTimeField.text = [NSString stringWithFormat:@"%@", picker.date];
    self.newevent.endTime = picker.date;
    NSLog(@"end time is %@", self.newevent.endTime);
  }
  
}
- (IBAction)doneEditing:(id)sender
{
  if ([self.startTimeField isFirstResponder])
  {
    [self.startTimeField resignFirstResponder];
  }
  if ([self.endTimeField isFirstResponder])
  {
    [self.endTimeField resignFirstResponder];
  }
  
}

- (IBAction)inputName:(UITextField *)sender {
  self.newevent.name = sender.text;
  NSLog(@"现在name里面有%@", self.newevent.name );
}
- (IBAction)inputType:(UITextField *)sender {
  self.newevent.categorye = sender.text.integerValue;
  NSLog(@"现在type里面有%ld",(long)self.newevent.categorye );
}

- (IBAction)inputStartTime:(UITextField *)sender {
  self.newevent.startTime = [[NSDate alloc] init];

}


- (IBAction)inputEndTime:(UITextField *)sender {
  self.newevent.startTime = [[NSDate alloc] init];
}


- (IBAction)inputMinMembers:(UITextField *)sender {
  self.newevent.minimum = sender.text.integerValue;
  NSLog(@"现在min members里面有%ld",(long)self.newevent.minimum );
}
- (IBAction)inputMaxMembers:(UITextField *)sender {
  self.newevent.maximum = sender.text.integerValue;
    NSLog(@"现在max members里面有%ld",(long)self.newevent.maximum );
}

- (IBAction)inputMinAge:(UITextField *)sender {
  self.newevent.mini_age = sender.text.integerValue;
    NSLog(@"现在min age里面有%ld",(long)self.newevent.mini_age );
}
- (IBAction)inputMaxAge:(UITextField *)sender {
  self.newevent.max_age = sender.text.integerValue;
  NSLog(@"现在max age里面有%ld",(long) self.newevent.max_age);
}
- (IBAction)inputDescription:(UITextField *)sender {
  self.newevent.descrip = sender.text;
  NSLog(@"现在des里面有%@",self.newevent.descrip);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
  [textField resignFirstResponder];
  return YES;
  
}  



-(IBAction)backgroundTap:(id)sender
{
  [self.namefield resignFirstResponder];
  [self.typeField resignFirstResponder];

  [self.minNumberField resignFirstResponder];
  [self.maxNumberField resignFirstResponder];
  [self.minAgeField resignFirstResponder];
  [self.maxAgeField resignFirstResponder];
  [self.desField resignFirstResponder];

 
}

@end
