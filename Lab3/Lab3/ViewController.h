//
//  ViewController.h
//  Lab2B
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"

@interface ViewController : UIViewController {
    IBOutlet UIButton *increaseButton, *decreaseButton;
    IBOutlet UILabel *numberOfSidesLabel, *shapeName, *rangeSides, *degreeLabel, *radianLabel;
    IBOutlet UISlider *numSidesSlider, *rotationSlider;

    IBOutlet UILabel *minSides, *maxSides;
    IBOutlet UISegmentedControl *lineType;
    
    IBOutlet PolygonView* polyView;
    
    PolygonShape *polygon;
}


-(IBAction)polyRotationSlider:(id)sender;
-(IBAction)increase:(id)sender;
-(IBAction)decrease:(id)sender;
-(IBAction)sliderChanged:(id)sender;
-(IBAction)lineTypeChanged:(id)sender;

@end
