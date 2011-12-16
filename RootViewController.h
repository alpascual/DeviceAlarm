//
//  RootViewController.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 10/15/11.
//  Copyright (c) 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LocationController.h"
#import "AccelerometerController.h"
#import "AdsController.h"
#import "AlertDelegate.h"
#import "PlaySound.h"
#import "SoundDelegate.h"
#import "SettingsController.h"
#import "MainController.h"

@interface RootViewController : UIViewController <AlertDelegate, SoundDelegate>
{
    UISwitch *mySwitch;
	AdsController *AdsView;
	
	LocationController *locationControl;
	AccelerometerController *accelerometerControl;
		
	PlaySound *sounds;
	UIBarButtonItem *settingsBtn;
	
	MainController *mainController;
}

@property (nonatomic, retain) IBOutlet UISwitch *mySwitch;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *settingsBtn;

@property (nonatomic, retain) LocationController *locationControl;
@property (nonatomic, retain) AccelerometerController *accelerometerControl;
@property (nonatomic, retain) PlaySound *sounds;

@property (nonatomic, retain) MainController *mainController;

@property (nonatomic, retain) IBOutlet AdsController *AdsView;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

- (IBAction) switchChanged;

- (IBAction) startCalled;

@end
