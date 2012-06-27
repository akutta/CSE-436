//
//  ThirdViewController.m
//  Lab4_noStoryboard
//
//  Created by Andrew Kutta on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"
#import "DetailedViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

-(IBAction)pushNextView:(id)sender {
    DetailedViewController* nextViewController = [[DetailedViewController alloc] initWithNibName:@"DetailedViewController" bundle:nil];
    nextViewController.navigationItem.title = @"Navigation Page 2";
    [self.navigationController pushViewController:nextViewController animated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Navigation Bar", @"Navigation Bar");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Navigation Part 1";
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
