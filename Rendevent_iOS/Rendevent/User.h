//
//  User.h
//  Rendevent
//
//  Created by LiaoYangguang on 5/2/16.
//  Copyright © 2016 LiaoYangguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, assign) NSUInteger event_Id;

@end
