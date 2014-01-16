//
//  PlaySound.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 2/4/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "PlaySound.h"


@implementation PlaySound

@synthesize soundDelegate;

-(void)playSound:(NSString *)nextSound
{	
	if (nextSound != nil) { 
		NSLog(@"before playing sound %@", nextSound);
		@try {
			
			NSString *path = [[NSBundle mainBundle] pathForResource:nextSound ofType:@"wav"];
			SystemSoundID soundID;
			AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
			
			AudioServicesAddSystemSoundCompletion (soundID,NULL,NULL,MyAudioServicesSystemSoundCompletionProc, /*(void*)*/ (__bridge void *)(self));
			AudioServicesPlaySystemSound (soundID);	
			
			NSLog(@"Playing sound from the queue %@", path);
			
            // this now kills the app
			//[path release];
		}
		@catch (NSException * e) {
			NSLog(@"Exception looking for sound");
		}
		
		
	}
	
}

void MyAudioServicesSystemSoundCompletionProc(SystemSoundID ssID, void *clientData)
{
	NSLog(@"Finished playing sounds");
	//cleanup
	//AudioServicesDisposeSystemSoundID(ssID);
	PlaySound *pSoundQueue = (__bridge PlaySound *)(clientData);
	//[pSoundQueue playQueue]; //it crashes here: EXC_BAD_ACCESS
	
	[pSoundQueue.soundDelegate finish];
}

@end
