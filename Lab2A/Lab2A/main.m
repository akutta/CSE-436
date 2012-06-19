//
//  main.m
//  Lab2A
//
//  Created by Andrew Kutta on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PolygonShape.h"


// Refactored cause it was going to be very ugly otherwise
PolygonShape *initPolygon(float min, float max, float sides) {
    PolygonShape* polygon = [[PolygonShape alloc] init];
    [polygon setMinimumNumberOfSides:min];
    [polygon setMaximumNumberOfSides:max];
    [polygon setNumberOfSides:sides];
    
    return polygon;
}

void PrintPolygonInfo() {
    NSMutableArray* polygons = [[NSMutableArray alloc] init];
    
    // setter call directly
    
    [polygons addObject:initPolygon(3, 7, 4)];
    [polygons addObject:initPolygon(5, 9, 6)];
    [polygons addObject:initPolygon(9, 12, 12)];
    
    // Custom initWithNumberOfSides
    [polygons addObject:[[PolygonShape alloc] initWithNumberOfSides:3 minimumNumberOfSides:3 maximumNumberOfSides:10]];
    [polygons addObject:[[PolygonShape alloc] initWithNumberOfSides:5 minimumNumberOfSides:3 maximumNumberOfSides:5]];
    
    
    // Output Descriptions:
    //      Should try and increase sides here.  But I was also supposed to output as I created polygon
    for ( PolygonShape* p in polygons ) {
        NSLog(@"%@",[p description]);
    }
    
    // Attempt to increase all number of sides
    for ( PolygonShape* p in polygons ) {
        [p setNumberOfSides:10];
    }
}

void PrintPathInfo() {
    
    NSLog(@"Print Path Information");
    NSLog(@"======================");
    
    // Find path to the home directory
    NSString *path = @"~";
    path = [path stringByStandardizingPath];
    NSLog(@"My home folder is at '%@'",path);
    
    // Get path components
    NSArray* components = [path pathComponents];
    
    // Iterate over each component
    for ( id item in components ) {
        NSLog(@"%@",item);
    }
}

void PrintProcessInfo() {
    NSLog(@"\n\n");
    NSLog(@"Print Process Information");
    NSLog(@"=========================");
    
    // Get current process information
    NSProcessInfo *procInfo = [NSProcessInfo processInfo];
    
    // Print it
    NSLog(@"Process Name: '%@' Process ID: '%d'", [procInfo processName], [procInfo processIdentifier]);
}

void PrintBookmarkInfo() {
    NSLog(@"\n\n");    
    NSLog(@"Print Bookmark Information");
    NSLog(@"==========================");
    
    // Create a dictionary and add indicated keys and urls
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dictionary setValue:[NSURL URLWithString:@"http://www.wustl.edu"] forKey:@"Washington University in St. Louis"];
    [dictionary setValue:[NSURL URLWithString:@"http://www.apple.com"] forKey:@"Apple"];
    [dictionary setValue:[NSURL URLWithString:@"http://www.google.com"] forKey:@"Google"];
    [dictionary setValue:[NSURL URLWithString:@"http://record.wustl.edu"] forKey:@"Washington University Record"];
    [dictionary setValue:[NSURL URLWithString:@"http://library.wustl.edu"] forKey:@"Washington University Library"];
    
    // Iterate over each key
    for (NSString *key in dictionary) {
        
        // Print only items that START with Washington
        // Event though I know the cases that I used, make lowercase as a more universal check
        //      Assumes not case-sensitive is wanted
        NSUInteger wordLocation = [[key lowercaseString] rangeOfString:@"washington"].location;
        if ( wordLocation == 0 ) { // 0 = Beginning of the String.  NSNotFound = Anywhere in string
            NSLog(@"Key:  '%@'  URL:  '%@'", key, [dictionary objectForKey:key]);
        }
    }
}


void PrintIntrospectionInfo() {
    NSLog(@"\n\n");
    NSLog(@"Print Introspection Information");
    NSLog(@"===============================");
    
    // Add stuff to an array
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[[NSString alloc] initWithString:@"Hello WashU!!!"]];
    [array addObject:[[NSURL alloc] initWithString:@"http://www.Google.com"]];
    [array addObject:[[NSDictionary alloc] init]];
    [array addObject:[NSProcessInfo processInfo]];
    [array addObject:[[NSMutableDictionary alloc] init]];
    [array addObject:[[NSMutableArray alloc] init]];
    
    
    // Iterate over each entry in the array
    // Since the array contains multiple types, type the entry as an id
    for (id entry in array) {
        
        // Output Information about each entry
        
        NSLog(@"Class name:  %@", NSStringFromClass([entry class]));
        NSLog(@"Is Member of NSString:  %@", ([entry isMemberOfClass:[NSString class]] ? @"YES" : @"NO"));
        NSLog(@"Is Kind of NSString:  %@",([entry isKindOfClass:[NSString class]] ? @"YES" : @"NO"));
        
        //NSLog(@"Responds to lowercaseString:  %@",([entry respondsToSelector:@selector(lowercaseString)] ? @"YES" : @"NO"));
        if ( [entry respondsToSelector:@selector(lowercaseString)] ) {
            NSLog(@"Responds to lowercaseString:  YES");
            NSLog(@"lowercaseString is:  %@",[entry lowercaseString]);
        } else {
            NSLog(@"Responds to lowercaseString:  NO");
        }
        
        NSLog(@"======================================");
    }
}

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        // insert code here...
        PrintPathInfo(); // Section 1
        PrintProcessInfo(); // Section 2
        PrintBookmarkInfo(); // Section 3
        PrintIntrospectionInfo(); // Section 4
        PrintPolygonInfo();         // Lab 2A
    }
    return 0;
}

