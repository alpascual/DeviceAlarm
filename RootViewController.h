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

@property (nonatomic, strong) IBOutlet UISwitch *mySwitch;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *settingsBtn;

@property (nonatomic, strong) LocationController *locationControl;
@property (nonatomic, strong) AccelerometerController *accelerometerControl;
@property (nonatomic, strong) PlaySound *sounds;

@property (nonatomic, strong) MainController *mainController;

@property (nonatomic, strong) IBOutlet AdsController *AdsView;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

- (IBAction) switchChanged;

- (IBAction) startCalled;

@end
