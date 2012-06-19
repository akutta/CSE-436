//
//  ViewController.m
//  Lab2B
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)updateLabels {
    shapeName.text = [polygon name];
    degreeLabel.text = [NSString stringWithFormat:@"Degrees:  %.02f",[polygon angleInDegrees]];
    radianLabel.text = [NSString stringWithFormat:@"Radians:  %.02f",[polygon angleInRadians]];
}

-(IBAction)increase:(id)sender {
    [polygon setNumberOfSides:([polygon numberOfSides]+1)];
    numberOfSidesLabel.text = [NSString stringWithFormat:@"%u",[polygon numberOfSides]];
    
    decreaseButton.enabled = YES;
    if ( [polygon numberOfSides] == [polygon maximumNumberOfSides] ) {
        increaseButton.enabled = NO;
    }
    
    [self updateLabels];
}

-(IBAction)decrease:(id)sender {
    [polygon setNumberOfSides:([polygon numberOfSides]-1)];
    numberOfSidesLabel.text = [NSString stringWithFormat:@"%u",[polygon numberOfSides]];
    
    increaseButton.enabled = YES;
    if ( [polygon numberOfSides] == [polygon minimumNumberOfSides] ) {
        decreaseButton.enabled = NO;
    }
    
    [self updateLabels];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    polygon = [[PolygonShape alloc] initWithNumberOfSides:numberOfSidesLabel.text.integerValue 
                                     minimumNumberOfSides:3 
                                     maximumNumberOfSides:12];
    
    rangeSides.text = [NSString stringWithFormat:@"Range: ( %u - %u )",
                       [polygon minimumNumberOfSides],
                       [polygon maximumNumberOfSides]];
    
    
    [self updateLabels];
    
    NSLog(@"My polygon:  %@",polygon);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
