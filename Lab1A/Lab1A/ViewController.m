//
//  ViewController.m
//  Lab1A
//
//  Created by Andrew Kutta on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize sliderLabel, imageView;

// Refactored out as exact same code is used in two places
-(UIImage*)scaleImage:(UIImage*)image toScale:(CGFloat)scale {
    // Annoying code to scale image properly
    CGRect rect = CGRectMake(0, 0, image.size.width*scale, image.size.height*scale);
    UIGraphicsBeginImageContext(imageView.frame.size);
    [image drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(IBAction)sliderChanged:(id)sender 
{
    UISlider *imageScaler = (UISlider*)sender;
    float value = imageScaler.value;
    
    
    // Automatic Reference Counting so no need to release or autorelease this
    // Set Slider Text to new scale
    NSString* newScaleText = [[NSString alloc] initWithFormat:@"Scale:  %.02f", value];
    self.sliderLabel.text = newScaleText;
    
    // Scale the image based on the value of the slider
    imageView.image = [self scaleImage:originalImage toScale:value];
    
    
    // Offset the image so it remains centered
    if (value == 1) {
        // No computation required
        imageView.frame = originalFrame;
    } else { 
        //  Calculate offsets and set the frame origin accordingly.
        //  Scales the frame as well so when the origin is offscreen we don't have a awkward cropped image
        CGFloat widthOffset = originalImage.size.width*(1-value)/2;
        CGFloat heightOffset = originalImage.size.height*(1-value)/2;
        CGRect newFrame = CGRectMake(originalFrame.origin.x + widthOffset, 
                                     originalFrame.origin.y + heightOffset, 
                                     originalFrame.size.width * value,
                                     originalFrame.size.height * value);
        imageView.frame = newFrame;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString* newScaleText = [[NSString alloc] initWithFormat:@"Scale: 1.00"];
    self.sliderLabel.text = newScaleText;
    
    // Figure out the scale of the image relative to the imageView frame
    CGFloat heightScale = imageView.frame.size.height/imageView.image.size.height;
    CGFloat widthScale =  imageView.frame.size.width/imageView.image.size.width;
    
    // Scale so the image fits in the frame
    imageView.image = [self scaleImage:imageView.image toScale:MIN(heightScale,widthScale)];
    
    // Store variables for later reference
    originalImage = [imageView.image copy]; // Slider scales based on this image dimension instead of current ( Easier math higher memory )
    originalFrame = imageView.frame;        // Slider scales frame based on this frame instead of current     ( Easier math higher memory )
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
