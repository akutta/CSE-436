//
//  PolygonView.m
//  Lab3
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PolygonView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PolygonView
@synthesize  angleOffset = _angleOffset;


+ (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides {
    
    float minDimension = MIN(rect.size.width, rect.size.height);
    
    CGPoint center = CGPointMake(minDimension / 2.0, minDimension / 2.0 - 5.0);
    float radius = 0.8 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / numberOfSides;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x + curX, 
                                                                center.y + curY)]];
    }
    return result;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setLineType:(BOOL)segmented {
    segmentedLine = segmented;
}


- (CGGradientRef)createGradient:(float)alpha blueStart:(float)blueLocation
{
    CGFloat locations[4];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:4];
    UIColor *color = [UIColor blueColor];//[self colorByChangingAlphaTo:[UIColor blueColor] newAlpha:alpha];
    [colors addObject:(id)[color CGColor]];
    locations[0] = 0.0;
    color = [self colorByChangingAlphaTo:[UIColor darkGrayColor] newAlpha:alpha];
    [colors addObject:(id)[color CGColor]];
    locations[1] = 0.25;
    color = [self colorByChangingAlphaTo:[UIColor darkGrayColor] newAlpha:alpha];
    [colors addObject:(id)[color CGColor]];
    locations[2] = blueLocation;
    color = [UIColor blueColor];
    [colors addObject:(id)[color CGColor]];
    locations[3] = 1.0;
    
    CGGradientRef ret = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, locations);
    CGColorSpaceRelease(space);
    return ret;
}

-(void)drawShape {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();    
    
    CGGradientRef newGradient = [self createGradient:1.0 blueStart:.75];
    CGContextDrawLinearGradient(contextRef, newGradient, 
                                CGPointMake(0, 0),
                                CGPointMake(self.frame.size.width, 0),
                                kCGGradientDrawsBeforeStartLocation);
    
    newGradient = [self createGradient:.25 blueStart:.6];
    CGContextDrawLinearGradient(contextRef, newGradient, 
                                CGPointMake(0, 0),
                                CGPointMake(0,self.frame.size.height),
                                kCGGradientDrawsBeforeStartLocation);
    
    float minDimension = MIN(self.frame.size.width, self.frame.size.height);
    CGPoint center = CGPointMake(minDimension / 2.0, minDimension / 2.0 - 5.0);
    CGContextTranslateCTM(contextRef, center.x, center.y);
    CGContextRotateCTM(contextRef, _angleOffset);
    CGContextTranslateCTM(contextRef, -center.x, -center.y);    
    
    NSValue *firstPoint = nil;
    for ( NSValue *point in points ) {
        
        if ( firstPoint == nil ) {
            CGContextMoveToPoint(contextRef, [point CGPointValue].x, 
                                             [point CGPointValue].y);
            firstPoint = point;
            continue;
        }
        CGContextAddLineToPoint(contextRef, [point CGPointValue].x, [point CGPointValue].y);
    }
    
    CGContextAddLineToPoint(contextRef, [firstPoint CGPointValue].x, [firstPoint CGPointValue].y);
    
    CGContextSetLineWidth(contextRef,3.0f);
    CGContextSetFillColorWithColor(contextRef, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(contextRef, [UIColor redColor].CGColor);
    
    CGFloat dashes[] = {12.0, 4.0};
    if ( segmentedLine ) 
        CGContextSetLineDash(contextRef, 0.0, dashes, 2);
    CGContextDrawPath(contextRef, kCGPathFillStroke);
}

-(void)setupViewLook {
    [self layer].borderColor = [[UIColor blackColor] CGColor];
    [self layer].borderWidth = 3.0f;
    [self.window addSubview:shapeLabel];
    [self.window bringSubviewToFront:shapeLabel];
    shapeLabel.text = @"Test";
}

- (void)drawRect:(CGRect)rect {
    
    [self setupViewLook];    
    [self drawShape];
    
}

- (void)setPoints:(NSArray*)pointArray {
    points = pointArray;
}



//
// Modified version of http://www.cocoanetics.com/2009/10/manipulating-uicolors/
//
- (UIColor *)colorByChangingAlphaTo:(UIColor*)color newAlpha:(CGFloat)newAlpha
{
	// oldComponents is the array INSIDE the original color
	// changing these changes the original, so we copy it
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([color CGColor]);
	int numComponents = CGColorGetNumberOfComponents([color CGColor]);
	CGFloat newComponents[4];
    
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[0];
			newComponents[2] = oldComponents[0];
			newComponents[3] = newAlpha;
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[1];
			newComponents[2] = oldComponents[2];
			newComponents[3] = newAlpha;
			break;
		}
	}
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
	return retColor;
}

@end
