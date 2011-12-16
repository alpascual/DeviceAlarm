//
//  RootViewController.m
//  DeviceAlarm
//
//  Created by Albert Pascual on 10/15/11.
//  Copyright (c) 2011 Al. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize mySwitch;
@synthesize accelerometerControl, locationControl;
@synthesize AdsView;

@synthesize sounds;
@synthesize settingsBtn;

@synthesize mainController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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
		
		if ( self.AdsView == nil )
			self.AdsView = [[AdsController alloc] initWithNibName:@"AdsController" bundle:nil];
        
		// iAds requires a View instead of a Window
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			self.AdsView.modalPresentationStyle = UIModalPresentationFullScreen;
			self.AdsView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
			[self.AdsView presentModalViewController:self.AdsView animated:YES];
			
			[self presentModalViewController:self.AdsView animated:YES];
		}
		else
		{
			
			[self.navigationController pushViewController:self.AdsView animated:YES];
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

- (void) moveHappen
{
	NSLog(@"Delegate called, all good with the world");
	
	[self.locationControl stop];
	[self.accelerometerControl stop];
	
	if ( self.sounds == nil)
		self.sounds = [[PlaySound alloc] init];
	
	self.sounds.soundDelegate = self;
	
	[self.sounds playSound:@"alarm"];
	
}

- (void) finish
{
	NSLog(@"Sound finished, enable everything again");
	
	[self.locationControl start];
	[self.accelerometerControl start];
}

- (IBAction) startCalled
{
	
	// iAds requires a View instead of a Window
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		self.mainController = [[MainController alloc] initWithNibName:@"iPadMainController" bundle:nil];
		
		self.mainController.modalPresentationStyle = UIModalPresentationFullScreen;
		self.mainController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    		
		[self presentModalViewController:self.mainController animated:YES];
	}
	else
	{
		self.mainController = [[MainController alloc] initWithNibName:@"MainController" bundle:nil];
        [self.navigationController pushViewController:self.mainController animated:YES];	
	}
}

- (void)dealloc {
    [self.locationControl release];
    self.locationControl = nil;
    [self.accelerometerControl release];
    self.accelerometerControl = nil;
    [self.sounds release];
    self.sounds = nil;
}


@end
