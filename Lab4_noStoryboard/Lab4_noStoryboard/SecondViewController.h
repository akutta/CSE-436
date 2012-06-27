//
//  SecondViewController.h
//  Lab4_noStoryboard
//
//  Created by Andrew Kutta on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>  {
    NSMutableArray* listOfItems;
}
@end
