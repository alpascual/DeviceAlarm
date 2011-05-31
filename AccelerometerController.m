//
//  AccelerometerController.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "AccelerometerController.h"


@implementation AccelerometerController

@synthesize accelerometerManager;
@synthesize noiseDelegate;


- (id) init {
    self = [super init];
    if (self != nil) {
        //self.accelerometerManager = [UIAccelerometer sharedAccelerometer];
        //self.accelerometerManager.delegate = self; 
		
		
    }
    return self;
}

- (void) start
{
	iTries = 0;
    iTriesHand = 0;
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
        
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(handleProximityChangeNotification:) 
                                           name:UIDeviceProximityStateDidChangeNotification object:nil];         
}

-(void)handleProximityChangeNotification:(NSNotification*)notification {
    
    /*iTriesHand = iTriesHand + 1;
    if ( iTriesHand < 2 )
        return;*/
    
    if([UIDevice currentDevice].proximityState)
    {
        NSLog(@"First mode/ Hand on the sensor ");
        [self.noiseDelegate moveHappen];
    }
    else
    {
        NSLog(@"Second mode/ Hand off the sensor");
    }
    
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
}

- (void) stop
{
	[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	//labelX.text = [NSString stringWithFormat:@"%@%f", @"X: ", acceleration.x];
	//labelY.text = [NSString stringWithFormat:@"%@%f", @"Y: ", acceleration.y];
	//labelZ.text = [NSString stringWithFormat:@"%@%f", @"Z: ", acceleration.z];
	
	//	self.progressX.progress = ABS(acceleration.x);
	//	self.progressY.progress = ABS(acceleration.y);
	//	self.progressZ.progress = ABS(acceleration.z);
	iTries++;
	
	NSLog(@"accelerometer goes: %@", [acceleration description]);	
			
	if ( X != round(acceleration.x) ||
		 Y != round(acceleration.y) ||
		 Z != round(acceleration.z) )
	{		
		X =  round(acceleration.x);
		Y =  round(acceleration.y);
		Z =  round(acceleration.z);
		
		if (iTries < 5 )
			return;
		
		NSLog(@"Make some noise: %f %f %f", round(acceleration.x), round(acceleration.y), round(acceleration.z));
		
		[self.noiseDelegate moveHappen];
	}
	
}


@end
