//
//  AppDelegate_Shared.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


#import "LocationController.h"
#import "AccelerometerController.h"
#import "AdsController.h"
#import "AlertDelegate.h"
#import "PlaySound.h"
#import "SoundDelegate.h"
#import "SettingsController.h"
#import "MainController.h"


@interface AppDelegate_Shared : NSObject <UIApplicationDelegate, AlertDelegate, SoundDelegate> {
    
    UIWindow *window;
	UISwitch *mySwitch;
	AdsController *AdsView;
	
	LocationController *locationControl;
	AccelerometerController *accelerometerControl;
	
	UINavigationController *navigationController;
	
	PlaySound *sounds;
	UIBarButtonItem *settingsBtn;
	
	MainController *mainController;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISwitch *mySwitch;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *settingsBtn;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

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

