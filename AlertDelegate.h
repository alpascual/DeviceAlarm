//
//  AlertDelegate.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 2/6/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AlertDelegate


-(void) moveHappen;
-(void) settingCalled:(BOOL)ring:(NSString*)phone;

@end
