//
//  PolygonView.m
//  Lab3
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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

-(void)drawShape {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();    
    
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

@end
