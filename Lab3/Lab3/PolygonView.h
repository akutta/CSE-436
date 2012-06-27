//
//  PolygonView.h
//  Lab3
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolygonView : UIView {
    NSArray *points;
    UILabel *shapeLabel;
    BOOL segmentedLine;
    
    CGPoint initialTouch;
}

@property (nonatomic) float angleOffset;

- (void)setShapeName:(NSString*)shapeName;
- (void)setPoints:(NSArray*)points;
-(void)setLineType:(BOOL)segmented;
+ (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides;
- (UIColor *)colorByChangingAlphaTo:(UIColor*)color newAlpha:(CGFloat)newAlpha;

@end
