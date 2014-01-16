//
//  MainController.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 2/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingsController.h"
#import "LocationController.h"
#import "AccelerometerController.h"
#import "PlaySound.h"
#import "AdsController.h"
#import "GCPINViewController.h"
#import "DisableDelegate.h"
#import "LTHPasscodeViewController.h"


@interface MainController : UIViewController <AlertDelegate, SoundDelegate, GCPINViewControllerDelegate, DisableDelegate>{

	SettingsController *settings;
	
	LocationController *locationControl;
	AccelerometerController *accelerometerControl;
	PlaySound *sounds;
	AdsController *AdsView;
    BOOL doRing;
    NSString *phoneNumber;
    UIBarButtonItem *settingsButton;
    NSTimer *highlightTimer;
    
    UISwitch *onAndOff;
    
}

@property (nonatomic, strong) SettingsController *settings;

@property (nonatomic, strong) LocationController *locationControl;
@property (nonatomic, strong) AccelerometerController *accelerometerControl;
@property (nonatomic, strong) PlaySound *sounds;
@property (nonatomic, strong) AdsController *AdsView;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *settingsButton;
@property (nonatomic, strong) IBOutlet UISwitch *onAndOff;

@property (nonatomic, strong) NSTimer *highlightTimer;


- (IBAction) settingsCalled;

- (IBAction) switchChanged;

- (IBAction) changedPin;

@end
