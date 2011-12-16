//
//  AdsController.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AudioToolbox/AudioToolbox.h>
#import "GCPINViewController.h"
#import "DisableDelegate.h"


@interface AdsController : UIViewController <GCPINViewControllerDelegate>{

	//ADBannerView *iAdView;
    BOOL gAudioSessionInited;
    NSTimer *highlightTimer;
    NSTimer *checkTimer;
    
    id <DisableDelegate> Disable;
    
    UIViewController  *myParent;
    BOOL isDisabled;
}

//@property (nonatomic, retain) IBOutlet ADBannerView *iAdView;
@property (nonatomic, retain) NSTimer *highlightTimer;
@property (nonatomic, retain) NSTimer *checkTimer;
@property (nonatomic, retain) id <DisableDelegate> Disable;
@property (nonatomic, retain) UIViewController  *myParent;

- (void) showPassword;

@end
