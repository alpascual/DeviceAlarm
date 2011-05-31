//
//  AppDelegate_Shared.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "AppDelegate_Shared.h"


@implementation AppDelegate_Shared

@synthesize window;
@synthesize mySwitch;
@synthesize accelerometerControl, locationControl;
@synthesize AdsView;
@synthesize navigationController;
@synthesize sounds;
@synthesize settingsBtn;

@synthesize mainController;


#pragma mark -
#pragma mark Application lifecycle

/**
 Save changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    
    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DeviceAlarm" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DeviceAlarm.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [window release];
	
	[self.locationControl release];
	self.locationControl = nil;
	[self.accelerometerControl release];
	self.accelerometerControl = nil;
	[self.sounds release];
	self.sounds = nil;
	
	
    [super dealloc];
}




- (IBAction) switchChanged
{
	if ( self.locationControl == nil && self.accelerometerControl == nil)
	{
		self.locationControl = [[LocationController alloc] init];		
		self.accelerometerControl = [[AccelerometerController alloc] init];
		
		self.locationControl.noiseDelegate = self;
		self.accelerometerControl.noiseDelegate = self;
		
		[self.locationControl start];
		[self.accelerometerControl start];
		
		if ( self.AdsView == nil )
			self.AdsView = [[AdsController alloc] initWithNibName:@"AdsController" bundle:nil];
			
		// iAds requires a View instead of a Window
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			self.AdsView.modalPresentationStyle = UIModalPresentationFullScreen;
			self.AdsView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
			[self.AdsView presentModalViewController:self.AdsView animated:YES];
			
			[self.window addSubview: self.AdsView.view];
			[self.window makeKeyAndVisible];
		}
		else
		{
			if ( self.navigationController == nil )
				self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.AdsView];
			
			[self.window addSubview: [navigationController view]];
			[self.window makeKeyAndVisible];
			
			//[self.navigationController pushViewController:self.AdsView animated:YES];
		}
	}
	else {
		[self.locationControl stop];
		[self.accelerometerControl stop];
		
		[self.locationControl release];
		[self.accelerometerControl release];
		
		self.locationControl = nil;
		self.accelerometerControl = nil;
	}

}

- (void) moveHappen
{
	NSLog(@"Delegate called, all good with the world");
	
	[self.locationControl stop];
	[self.accelerometerControl stop];
	
	if ( self.sounds == nil)
		self.sounds = [[PlaySound alloc] init];
	
	self.sounds.soundDelegate = self;
	
	[self.sounds playSound:@"alarm"];
	
}

- (void) finish
{
	NSLog(@"Sound finished, enable everything again");
	
	[self.locationControl start];
	[self.accelerometerControl start];
}

- (IBAction) startCalled
{
	
	// iAds requires a View instead of a Window
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self.mainController = [[MainController alloc] initWithNibName:@"iPadMainController" bundle:nil];
		
		self.mainController.modalPresentationStyle = UIModalPresentationFullScreen;
		self.mainController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		[self.mainController presentModalViewController:self.mainController animated:YES];
		
		[self.window addSubview: self.mainController.view];
		[self.window makeKeyAndVisible];
	}
	else
	{
		self.mainController = [[MainController alloc] initWithNibName:@"MainController" bundle:nil];
		if ( self.navigationController == nil )
			self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.mainController];
		
		[self.window addSubview: [navigationController view]];
		[self.window makeKeyAndVisible];
		
	}
}

@end

