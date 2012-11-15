//
//  Nov15AppDelegate.h
//  Nov15
//
//  Created by MacBook on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class View;

@interface Nov15AppDelegate : UIResponder <UIApplicationDelegate>{
	View *view;
	UIWindow *_window;
}

@property (strong, nonatomic) UIWindow *window;

@end
