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


@interface AdsController : UIViewController <ADBannerViewDelegate>{

	//ADBannerView *iAdView;
    BOOL gAudioSessionInited;
}

//@property (nonatomic, retain) IBOutlet ADBannerView *iAdView;

@end
