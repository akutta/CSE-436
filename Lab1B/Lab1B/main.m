//
//  main.m
//  Lab1B
//
//  Created by Andrew Kutta on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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
        
    }
    return 0;
}

