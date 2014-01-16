//
//  PlaySound.h
//  DeviceAlarm
//
//  Created by Albert Pascual on 2/4/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

#import "SoundDelegate.h"

@interface PlaySound : NSObject {

	id <SoundDelegate> soundDelegate;
}

@property (strong, nonatomic) id <SoundDelegate> soundDelegate;

-(void)playSound:(NSString *)nextSound;
void MyAudioServicesSystemSoundCompletionProc(SystemSoundID ssID, void *clientData);

@end
