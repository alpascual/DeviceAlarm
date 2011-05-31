//
//  LocationController.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "AlertDelegate.h"

@interface LocationController : NSObject <CLLocationManagerDelegate> {

	CLLocationManager *locationManager;
	float trueHeading;
	float magneticHeading;
	int iTries;
	
	id <AlertDelegate> noiseDelegate;
	
}

@property (nonatomic, retain) CLLocationManager *locationManager;  
@property (retain, nonatomic) id <AlertDelegate> noiseDelegate;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

- (void) start;
- (void) stop;

@end
