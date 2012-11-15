//
//  View.h
//  Nov15
//
//  Created by MacBook on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewNext;

@interface View: UIView {
	NSUInteger tapCount;	//1 for single tap, 2 for double, 0 for no tap
	NSTimeInterval delay; 	//after this number of seconds, a tap wears off
}

@end
