//
//  AccelerometerController.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#import "AlertDelegate.h"

@interface AccelerometerController : NSObject <UIAccelerometerDelegate>{
	
	UIAccelerometer *accelerometerManager;	
	
	float X;
	float Y;
	float Z;
	
	id <AlertDelegate> noiseDelegate;
	
	int iTries;
    int iTriesHand;
	
}

@property (nonatomic, strong) UIAccelerometer *accelerometerManager;
@property (strong, nonatomic) id <AlertDelegate> noiseDelegate;
@property (strong, nonatomic) CMMotionManager *coreMotion;

- (void) start;
- (void) stop;

@end
