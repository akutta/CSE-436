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

-(void)setRotationValue:(float)radians {
    if ( radians <= 2*M_PI && radians >= 0 ) {
        rotationSlider.value = radians * 180 / M_PI;
        [polyView setNeedsDisplay];
    }
}

-(IBAction)polyRotationSlider:(id)sender {
    polyView.angleOffset = rotationSlider.value * M_PI/180;
    [polyView setNeedsDisplay];
}

-(void)updateLabels {
    shapeName.text = [polygon name];
    degreeLabel.text = [NSString stringWithFormat:@"%.02f",[polygon angleInDegrees]];
    radianLabel.text = [NSString stringWithFormat:@"%.02f",[polygon angleInRadians]];
    numberOfSidesLabel.text = [NSString stringWithFormat:@"%u",[polygon numberOfSides]];
    
    
    [polyView setPoints:[PolygonView pointsForPolygonInRect:polyView.frame numberOfSides:[polygon numberOfSides]]];
    [self lineTypeChanged:nil];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[polygon numberOfSides] forKey:@"numSides"];    
    [defaults synchronize];
}

-(IBAction)lineTypeChanged:(id)sender {
    if (lineType.selectedSegmentIndex == 1 ) { 
        [polyView setLineType:YES];
    } else {
        [polyView setLineType:NO];
    }
    [polyView setNeedsDisplay];
}

-(IBAction)sliderChanged:(id)sender {
    [polygon setNumberOfSides:(int)numSidesSlider.value];
    [self updateLabels];
    
    
    if ( [polygon numberOfSides] == [polygon maximumNumberOfSides] ) {
        increaseButton.enabled = NO;
        decreaseButton.enabled = YES;
    } else if ( [polygon numberOfSides] == [polygon minimumNumberOfSides] ) {
        decreaseButton.enabled = NO;
        increaseButton.enabled = YES;
    } else {
        increaseButton.enabled = YES;
        decreaseButton.enabled = YES;
    }
}

-(IBAction)increase:(id)sender {
    [polygon setNumberOfSides:([polygon numberOfSides]+1)];
    
    decreaseButton.enabled = YES;
    if ( [polygon numberOfSides] == [polygon maximumNumberOfSides] ) {
        increaseButton.enabled = NO;
    }
    numSidesSlider.value = [polygon numberOfSides];
    [self updateLabels];
}

-(IBAction)decrease:(id)sender {
    [polygon setNumberOfSides:([polygon numberOfSides]-1)];
    
    increaseButton.enabled = YES;
    if ( [polygon numberOfSides] == [polygon minimumNumberOfSides] ) {
        decreaseButton.enabled = NO;
    }
    numSidesSlider.value = [polygon numberOfSides];
    [self updateLabels];
}

- (void)viewDidLoad
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int numSides = [defaults integerForKey:@"numSides"];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ( numSides == 0 ) {
        NSLog(@"Using Default Value.");
        polygon = [[PolygonShape alloc] initWithNumberOfSides:numberOfSidesLabel.text.integerValue 
                                         minimumNumberOfSides:3 
                                         maximumNumberOfSides:12];
    } else {
        NSLog(@"Loading From User Preferences");
        polygon = [[PolygonShape alloc] initWithNumberOfSides:numSides
                                         minimumNumberOfSides:3 
                                         maximumNumberOfSides:12];
    }
    
    rangeSides.text = [NSString stringWithFormat:@"Range: ( %u - %u )",
                       [polygon minimumNumberOfSides],
                       [polygon maximumNumberOfSides]];
    
    
    numSidesSlider.maximumValue = [polygon maximumNumberOfSides];
    numSidesSlider.minimumValue = [polygon minimumNumberOfSides];
    numSidesSlider.value = [polygon numberOfSides];
    
    minSides.text = [NSString stringWithFormat:@"%u",[polygon minimumNumberOfSides]];
    maxSides.text = [NSString stringWithFormat:@"%u",[polygon maximumNumberOfSides]];
    
    rotationSlider.transform=CGAffineTransformRotate(rotationSlider.transform,90.0/180*M_PI);
    
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
