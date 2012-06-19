//
//  ViewController.h
//  Lab2B
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"

@interface ViewController : UIViewController {
    IBOutlet UIButton *increaseButton, *decreaseButton;
    IBOutlet UILabel *numberOfSidesLabel, *shapeName, *rangeSides, *degreeLabel, *radianLabel;
    
    @private
    PolygonShape *polygon;
}

-(IBAction)increase:(id)sender;
-(IBAction)decrease:(id)sender;

@end
