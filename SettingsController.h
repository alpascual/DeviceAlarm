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

@property (nonatomic,strong) IBOutlet UITextField *phoneNumber;
@property (nonatomic,strong) IBOutlet UISwitch *mySwitch;

@property (strong, nonatomic) id <AlertDelegate> noiseDelegate;


- (IBAction) saveCalled;
- (IBAction) settingChanged;


@end
