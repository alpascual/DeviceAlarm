//
//  AppDelegate_Shared.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class RootViewController;


@interface AppDelegate_Shared : UIResponder <UIApplicationDelegate> {
    
    UIWindow *window;
	
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (strong, nonatomic) RootViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;





@end

