//
//  AdsController.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 1/27/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "AdsController.h"


@implementation AdsController

//@synthesize iAdView;
@synthesize highlightTimer;
@synthesize Disable;
@synthesize myParent;
@synthesize checkTimer;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isDisabled = NO;
    
    if (!gAudioSessionInited)
    {
        AudioSessionInterruptionListener    inInterruptionListener = NULL;
        OSStatus    error;
        if ((error = AudioSessionInitialize (NULL, NULL, inInterruptionListener, NULL)))
        {
            NSLog(@"*** Error *** error in AudioSessionInitialize: %d.", (int)error);
        }
        else
        {
            gAudioSessionInited = YES;
        }
    }
    
    SInt32  ambient = kAudioSessionCategory_AmbientSound;
    if (AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (ambient), &ambient))
    {
        NSLog(@"*** Error *** could not set Session property to ambient.");
    }
    
    self.highlightTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(timerCallback:) userInfo: nil repeats: NO];
    
    self.checkTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(checktimerCallback:) userInfo: nil repeats: YES];
}

- (BOOL)pinView:(GCPINViewController *)pinView validateCode:(NSString *)code
{
    
    //[[LTHPasscodeViewController sharedUser] showForEnablingPasscodeInViewController: self];
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    
    NSString *storedPin = [myPrefs objectForKey:@"Pin"];
    
    if ( [storedPin isEqualToString:code] == YES )
    {
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {            
            [self dismissModalViewControllerAnimated:YES];   
            [self.parentViewController dismissModalViewControllerAnimated: YES];
            isDisabled = YES;
        }
        
        else
            [self.navigationController popToViewController:[self.navigationController viewControllers][1] animated:YES];
            //[self.navigationController popViewControllerAnimated:YES];
        
        // calling the delegate
        [self.Disable AlarmIsDisabled];
        
        return YES;
    }
    
    return NO;
}

- (void)timerCallback:(NSTimer *)timer {
    
    [self showPassword];    
}

- (void)checktimerCallback:(NSTimer *)timer {
    if ( isDisabled == YES )
    {
        [self.checkTimer invalidate];
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void) showPassword
{
    [[LTHPasscodeViewController sharedUser] showForEnablingPasscodeInViewController: self];
    
//    GCPINViewController *pinView = [[GCPINViewController alloc] initWithNibName:@"PINViewDefault" bundle:nil];
    
//    pinView.titleLabel = @"Enter the correct Pin to disable";
//    
//    pinView.delegate = self;
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//    {  
//        pinView.modalPresentationStyle = UIModalPresentationFormSheet;
//        pinView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentModalViewController:pinView animated:YES];			
//        [self dismissModalViewControllerAnimated:YES];
//    }
//    else
//    {
//        [self.navigationController pushViewController:pinView animated:YES];
//        
//    } 
//    
    //[pinView release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
