//
//  LocationController.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "LocationController.h"

@implementation LocationController

@synthesize locationManager;
@synthesize noiseDelegate;

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
		self.locationManager.distanceFilter = 25;
		
        self.locationManager.delegate = self; // send loc updates to myself
			
    }
    return self;
}

- (void) start
{		
	//self.noiseMaker = noise;
	//[self.locationManager startUpdatingLocation];
	iTries = 0;
	[self.locationManager startUpdatingHeading];
	
}

- (void) stop
{
	[self.locationManager stopUpdatingHeading];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	//NSLog(@"Heading: %@", [newHeading description]);	
	iTries++;
	
	if ( iTries < 20 )
	{
		trueHeading = [newHeading trueHeading];
		NSLog(@"Compass trying: %f", [newHeading trueHeading]);
		return;
	}
	
	if (trueHeading != [newHeading trueHeading])
	{
		NSLog(@"Make some compass noise: %f", [newHeading trueHeading]);
		trueHeading = [newHeading trueHeading];
		[self.noiseDelegate moveHappen];
	}
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);	
	
	if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) &&
		(oldLocation.coordinate.longitude != newLocation.coordinate.longitude))
	{		
		// Start going nuts
		NSLog(@"Alarm going with old location: %@", [oldLocation description]);	
	}	
	else
	{
		NSLog(@"Relax hasn't moved: %@", [oldLocation description]);	
	}
	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (void)dealloc {
    [self.locationManager release];
    [super dealloc];
}


@end
