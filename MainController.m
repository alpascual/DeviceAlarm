//
//  MainController.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 2/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "MainController.h"


@implementation MainController

@synthesize settings;
@synthesize accelerometerControl, locationControl;
@synthesize sounds;
@synthesize AdsView;
@synthesize phoneNumber;
@synthesize settingsButton;
@synthesize highlightTimer;
@synthesize onAndOff;


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
	
	self.title = @"Device Alarm";
    
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
        self.settingsButton.hidden = YES;
    }*/
    
    // check if the pin is set, if not call the view to set it
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"Pin"] == nil )
    {
        //  set timer
        self.highlightTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(timerCallback:) userInfo: nil repeats: NO];
        
          
    }
}

- (void)timerCallback:(NSTimer *)timer {
    
    [self changedPin];    
}

- (BOOL)pinView:(GCPINViewController *)pinView validateCode:(NSString *)code
{
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    
    NSString *storedPin = [myPrefs objectForKey:@"Pin"];
    
    if ( [storedPin isEqualToString:code] == YES )
    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {            
            [self dismissModalViewControllerAnimated:YES];            
            
        }
        
        else
        {
            //[self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        // calling the delegate
        [self AlarmIsDisabled];
        
        return YES;
        
    }
    
    return NO;
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


- (void)dealloc {
    [super dealloc];
	
	[self.settings release];
}


- (IBAction) settingsCalled
{	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self.settings = [[[SettingsController alloc] initWithNibName:@"iPadSettingsController" bundle:nil] autorelease];
		
		self.settings.modalPresentationStyle = UIModalPresentationFormSheet;
		self.settings.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		[self presentModalViewController:self.settings animated:YES];				
	}
	else
	{
		self.settings = [[[SettingsController alloc] initWithNibName:@"SettingsController" bundle:nil] autorelease];
		
		//if ( self.navigationController == nil )
		//	self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.settings];
		
		[self.navigationController pushViewController:self.settings animated:YES];
		
	}
    
    self.settings.noiseDelegate = self;
}


// Main methods
- (IBAction) switchChanged
{
	if ( self.locationControl == nil && self.accelerometerControl == nil)
	{
		self.locationControl = [[LocationController alloc] init];		
		self.accelerometerControl = [[AccelerometerController alloc] init];
		
		self.locationControl.noiseDelegate = self;
		self.accelerometerControl.noiseDelegate = self;
		
		[self.locationControl start];
		[self.accelerometerControl start];
		
		
		// Show the password screen
		GCPINViewController *pinView = [[[GCPINViewController alloc] initWithNibName:@"PINViewDefault" bundle:nil] autorelease];
        
        pinView.titleLabel = @"Enter the correct Pin to disable";
        
        pinView.delegate = self;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {  
            pinView.modalPresentationStyle = UIModalPresentationFormSheet;
            pinView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:pinView animated:YES];			
            [self dismissModalViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController pushViewController:pinView animated:YES];
            
        } 
       
	}
	else {
		[self.locationControl stop];
		[self.accelerometerControl stop];
		
		[self.locationControl release];
		[self.accelerometerControl release];
		
		self.locationControl = nil;
		self.accelerometerControl = nil;
	}
	
}

-(void) AlarmIsDisabled
{
    // Called when the alarm is disabled
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {        
        [self.AdsView dismissModalViewControllerAnimated:YES];
    }
    
    [self.sounds release];
    self.sounds = nil;
    
    [self.locationControl stop];
    [self.accelerometerControl stop];
    
    [self.locationControl release];
    [self.accelerometerControl release];
    
    self.locationControl = nil;
    self.accelerometerControl = nil;
    
  
    self.onAndOff.userInteractionEnabled = NO;
    // disable the alarm    
    [self.onAndOff setOn:FALSE animated:YES];
    self.onAndOff.on = FALSE;
    self.onAndOff.userInteractionEnabled = YES;
    
}

- (void) moveHappen
{
	NSLog(@"Delegate called, all good with the world");
	
	[self.locationControl stop];
	[self.accelerometerControl stop];
	
    if ( doRing == YES )
    {
        
        [self finish];
        
       // Make a phone call
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.phoneNumber]]];
        
    }
    else
    {
        if ( self.sounds == nil)
            self.sounds = [[PlaySound alloc] init];
	
        self.sounds.soundDelegate = self;
	
        [self.sounds playSound:@"alarm"];
    }
	
}

- (void) finish
{
	NSLog(@"Sound finished, enable everything again");
	
	[self.locationControl start];
	[self.accelerometerControl start];
}

-(void) settingCalled:(BOOL)ring:(NSString*)phone
{
    doRing = ring;
    self.phoneNumber = phone;
}

- (IBAction) changedPin
{
    GCPINViewController *pinView = [[[GCPINViewController alloc] initWithNibName:@"PINViewDefault" bundle:nil] autorelease];
    
    pinView.delegate = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {  
        pinView.modalPresentationStyle = UIModalPresentationFormSheet;
        pinView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentModalViewController:pinView animated:YES];				
    }
    else
    {
        [self.navigationController pushViewController:pinView animated:YES];
        
    } 
}


@end
