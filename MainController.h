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


@interface MainController : UIViewController <AlertDelegate, SoundDelegate>{

	SettingsController *settings;
	
	LocationController *locationControl;
	AccelerometerController *accelerometerControl;
	PlaySound *sounds;
	AdsController *AdsView;
    BOOL doRing;
    NSString *phoneNumber;
    UIBarButtonItem *settingsButton;
}

@property (nonatomic, retain) SettingsController *settings;

@property (nonatomic, retain) LocationController *locationControl;
@property (nonatomic, retain) AccelerometerController *accelerometerControl;
@property (nonatomic, retain) PlaySound *sounds;
@property (nonatomic, retain) AdsController *AdsView;
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *settingsButton;


- (IBAction) settingsCalled;


- (IBAction) switchChanged;
//- (IBAction) startCalled;

@end
