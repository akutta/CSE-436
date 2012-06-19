//
//  PolygonShape.m
//  Lab2A
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PolygonShape.h"

@implementation PolygonShape

@synthesize maximumNumberOfSides = _maximumNumberOfSides, 
            minimumNumberOfSides = _minimumNumberOfSides, 
                   numberOfSides = _numberOfSides;


-(id)init {
    self = [super init];
    return [self initWithNumberOfSides:5 minimumNumberOfSides:3 maximumNumberOfSides:10];
}

- (id)initWithNumberOfSides:(int)sides 
       minimumNumberOfSides:(int)min
       maximumNumberOfSides:(int)max 
{
    [self setMaximumNumberOfSides:max];
    [self setMinimumNumberOfSides:min];
    [self setNumberOfSides:sides];
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat:@"Hello I am a %u-sided polygon (aka a %@) with angles of %f degrees (%f radians)",
            [self numberOfSides],
            [self name],
            [self angleInDegrees],
            [self angleInRadians]];
}

-(NSString*)name {
    switch ( [self numberOfSides] ) {
        case 3:
            return @"Triangle";
        case 4:
            return @"Square";
        case 5:
            return @"Pentagon";
        case 6:
            return @"Hexagon";
        case 7:
            return @"Heptagon";
        case 8:
            return @"Octagon";
        case 9:
            return @"Nonagon";
        case 10:
            return @"Decagon";
        case 11:
            return @"Hendecagon";
        case 12:
            return @"Dodecagon";
        default:
            return @"Invalidly Initialized Polygon";
    }
}

-(float)angleInRadians {
    return [self angleInDegrees] * M_PI / 180;
}

-(float)angleInDegrees {
    return 180.0 * ( [self numberOfSides] - 2 ) / [self numberOfSides];
}

-(void)setMaximumNumberOfSides:(int)maximumNumberOfSides {
    if ( maximumNumberOfSides <= 12 ) {
        _maximumNumberOfSides = maximumNumberOfSides;
    } else {
        NSLog(@"Invalid Maximum Number of Sides:  %u is Greater than the Maximum of 12",maximumNumberOfSides);
    }
}

-(void)setMinimumNumberOfSides:(int)minimumNumberOfSides {
    if ( minimumNumberOfSides > 2 ) {
        _minimumNumberOfSides = minimumNumberOfSides;
    } else {
        NSLog(@"Invalid Minimum Number of Sides:  %u is Less than the minimum of 3",minimumNumberOfSides);
    }
}

-(void)setNumberOfSides:(int)numberOfSides {
    if ( numberOfSides <= [self maximumNumberOfSides] ) {
        if ( numberOfSides >= [self minimumNumberOfSides] ) {
            _numberOfSides = numberOfSides;
        } else {
            NSLog(@"Invalid number of sides: %u is less than the minimum of %u allowed",numberOfSides,[self minimumNumberOfSides]);
        }
    } else {
        NSLog(@"Invalid number of sides: %u is greater than the maximum of %u allowed",numberOfSides,[self maximumNumberOfSides]);
    }
}

@end
