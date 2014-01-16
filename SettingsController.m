//
//  SettingsController.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 2/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "SettingsController.h"


@implementation SettingsController

@synthesize phoneNumber, mySwitch;
@synthesize noiseDelegate;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    
    
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Retrieve phone number
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"PhoneToSave"] != nil )
        phoneNumber.text = [myPrefs stringForKey:@"PhoneToSave"];
    
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



- (IBAction) saveCalled
{
    
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    [myPrefs setObject:phoneNumber.text forKey:@"PhoneToSave"];
        
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{		
		[self dismissModalViewControllerAnimated:YES];
	}
	else {
		[self.navigationController popViewControllerAnimated:YES];
	}

}

- (IBAction) settingChanged
{
    [self.noiseDelegate settingCalled:mySwitch.on:phoneNumber.text];
}

@end
