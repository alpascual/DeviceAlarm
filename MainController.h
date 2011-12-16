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

@property (nonatomic, retain) SettingsController *settings;

@property (nonatomic, retain) LocationController *locationControl;
@property (nonatomic, retain) AccelerometerController *accelerometerControl;
@property (nonatomic, retain) PlaySound *sounds;
@property (nonatomic, retain) AdsController *AdsView;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *settingsButton;
@property (nonatomic, retain) IBOutlet UISwitch *onAndOff;

@property (nonatomic, retain) NSTimer *highlightTimer;


- (IBAction) settingsCalled;

- (IBAction) switchChanged;

- (IBAction) changedPin;

@end
