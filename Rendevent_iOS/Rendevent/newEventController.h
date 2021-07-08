//
//  newEventController.h
//  Rendevent
//
//  Created by Jerry on 5/4/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import "ViewController.h"
#import "Event.h"
@interface newEventController : ViewController<UITextFieldDelegate>
-(IBAction)backgroundTap:(id)sender;
@property (strong, nonatomic) Event *newevent;
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *typeField;
@property (weak, nonatomic) IBOutlet UITextField *startTimeField;

@property (weak, nonatomic) IBOutlet UITextField *endTimeField;


@property (weak, nonatomic) IBOutlet UITextField *minNumberField;
@property (weak, nonatomic) IBOutlet UITextField *maxNumberField;
@property (weak, nonatomic) IBOutlet UITextField *minAgeField;
@property (weak, nonatomic) IBOutlet UITextField *maxAgeField;
@property (weak, nonatomic) IBOutlet UITextField *desField;
@end
