//
//  PolygonShape.h
//  Lab2A
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PolygonShape : NSObject {
    // instance variables
    int _numberOfSides, _minimumNumberOfSides, _maximumNumberOfSides;
}

/*
 •'numberOfSides – an'int'value
 •'minimumNumberOfSides – an'int'value
 •'maximumNumberOfSides – an'int'value
 •'angleInDegrees – a'float'value,'readonly
 •'angleInRadians – a'float'value,'readonly
 •'name – an'NSString'object,'readonly
 */

@property (nonatomic) int numberOfSides;
@property (nonatomic) int minimumNumberOfSides;
@property (nonatomic) int maximumNumberOfSides;
@property (readonly) float angleInDegrees;
@property (readonly) float angleInRadians;
@property (readonly) NSString *name;

- (id)initWithNumberOfSides:(int)sides 
       minimumNumberOfSides:(int)min
       maximumNumberOfSides:(int)max;

@end
