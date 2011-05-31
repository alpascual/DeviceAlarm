//
//  SettingsController.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 2/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AlertDelegate.h"

@interface SettingsController : UIViewController {

	UITextField *phoneNumber;
    UISwitch *mySwitch;
    
    id <AlertDelegate> noiseDelegate;
}

@property (nonatomic,retain) IBOutlet UITextField *phoneNumber;
@property (nonatomic,retain) IBOutlet UISwitch *mySwitch;

@property (retain, nonatomic) id <AlertDelegate> noiseDelegate;


- (IBAction) saveCalled;
- (IBAction) settingChanged;


@end
