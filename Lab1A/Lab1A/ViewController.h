//
//  ViewController.h
//  Lab1A
//
//  Created by Andrew Kutta on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UILabel* sliderLabel;
    UIImageView* imageView;
    UIImage* originalImage; // Image after scaled to window in load view
    CGRect originalFrame;
}


@property (nonatomic, retain) IBOutlet UILabel* sliderLabel;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;

-(IBAction)sliderChanged:(id)sender;


@end
