//
//  View.m
//  Nov15
//
//  Created by MacBook on 11/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor whiteColor];
		tapCount = 0;
		delay = 3;
	}	
	return self;
}

- (void) noTap {	//called when no tap is currently being received
	tapCount = 0;
	[self setNeedsDisplay];
}


- (void) singleTap {	//called when a single tap is received.
	tapCount = 1;
	[self setNeedsDisplay];
	
	//After a few seconds, the single tap wears off.
	[self performSelector: @selector(noTap) withObject: nil
			   afterDelay: delay];
}


- (void) doubleTap {	//called when a double tap is received
	tapCount = 2;
	[self setNeedsDisplay];
	
	//After a few seconds, the double tap wears off.
	[self performSelector: @selector(noTap) withObject: nil
			   afterDelay: delay];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {	
	UITouch *touch = [touches anyObject];
	
	if (touch.tapCount == 1) {
		[self performSelector: @selector(singleTap) withObject: nil
				   afterDelay: 0.3];
	} else if (touch.tapCount == 2) {
		[self doubleTap];
	}
}


- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	UITouch *touch = [touches anyObject];
	
	if (touch.tapCount == 2) {
		[NSObject cancelPreviousPerformRequestsWithTarget: self];
	}
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect
{
	// Drawing code
	CGFloat w = self.bounds.size.width;
	CGFloat h = self.bounds.size.height;
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	//seven red stripes
	CGContextBeginPath(c);
	//CGContextAddRect(c, CGRectMake( 0 * w / 13, 0, w / 13, h));
	//CGContextAddRect(c, CGRectMake( 2 * w / 13, 0, w / 13, h));
	//CGContextAddRect(c, CGRectMake( 4 * w / 13, 0, w / 13, h));
	//CGContextAddRect(c, CGRectMake( 6 * w / 13, 0, w / 13, h));
	//CGContextAddRect(c, CGRectMake( 8 * w / 13, 0, w / 13, h));
	//CGContextAddRect(c, CGRectMake(10 * w / 13, 0, w / 13, h));
	//CGContextAddRect(c, CGRectMake(12 * w / 13, 0, w / 13, h));
	for (int i = 0; i <= 12; i = i + 2){
		CGContextAddRect(c, CGRectMake(i * w /13, 0, w / 13, h));
	}
	
	CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
	CGContextFillPath(c);
	
	//blue union jack
	CGContextBeginPath(c);
	CGContextAddRect(c, CGRectMake(w * 6 / 13, 0, w * 7 / 13, h * 2 / 5));
	CGContextSetRGBFillColor(c, 0.0, 0.0, 1.0, 1.0);
	CGContextFillPath(c);
	
	//White star has 5 vertices (points).
	CGPoint center = CGPointMake((6 + 3.5) * w / 13, h / 5); //of union jack
	CGFloat radius = h / 10;	//of circle that the 5 vertices touch
	CGContextBeginPath(c);
	
	CGFloat theta = 0;		//Start with vertex pointing to right.
	CGContextMoveToPoint(c,
						 center.x + radius * cosf(theta),
						 center.y - radius * sinf(theta)
						 );
	
	theta += 2 * M_PI * 2 / 5;		//vertex pointing to upper left
	CGContextAddLineToPoint(c,
							center.x + radius * cosf(theta),
							center.y - radius * sinf(theta)
							);
	
	theta += 2 * M_PI * 2 / 5;		//vertex pointing to lower right
	CGContextAddLineToPoint(c,
							center.x + radius * cosf(theta),
							center.y - radius * sinf(theta)
							);
	
	theta += 2 * M_PI * 2 / 5;		//vertex pointing to upper right
	CGContextAddLineToPoint(c,
							center.x + radius * cosf(theta),
							center.y - radius * sinf(theta)
							);
	
	theta += 2 * M_PI * 2 / 5;		//vertex pointing to lower left
	CGContextAddLineToPoint(c,
							center.x + radius * cosf(theta),
							center.y - radius * sinf(theta)
							);
	
	//Works even though the star's outline intersects with itself.
	CGContextClosePath(c);
	CGContextSetRGBFillColor(c, 1.0, 1.0, 1.0, 1.0);
	CGContextFillPath(c);

	
	//Write Question
	UIFont *font00 = [UIFont boldSystemFontOfSize: 20.0];
    NSString *string00 = @"Which is the next President?"; 
	CGSize size00 = [string00 sizeWithFont: font00];
	CGPoint point00 = CGPointMake((w - size00.width) / 2 , size00.height + 20);
	CGContextRef c_string00 = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(c_string00, 0, 0, 0, 1);
	[string00 drawAtPoint: point00 withFont: font00];
			
    //inital Photo&String
	UIImage *image1 = [UIImage imageNamed: @"barack_obama.jpg"];
	UIImage *image2 = [UIImage imageNamed: @"mitt_romney.jpg"];
	NSString *string0 = @"Elect! (Double Click!!)";
	NSString *string1 = @"Democratic";
	NSString *string2 = @"Republican";		
	
	//Change Phote&String
	UIImage	*image1a = [UIImage imageNamed: @"obama_smiling.jpg"];
	UIImage *image2a = [UIImage imageNamed: @"romney_lose.jpg"];
	NSString *string0a = @"YES HE IS!!";
	NSString *string1a = @"YES";
	NSString *string2a = @"NO";		
	
	
	//upper left corner of image1
	CGPoint point1 = CGPointMake(
								 (w - image1.size.width) / 2,
								 h - image1.size.height - image2.size.height - 40);
	
	//upper left corner of image2
	CGPoint point2 = CGPointMake(
								 (w - image2.size.width) / 2,
								 h - image2.size.height - 20);
			
	//set string
	UIFont *font0 = [UIFont boldSystemFontOfSize: 20.0];
	UIFont *font1 = [UIFont boldSystemFontOfSize: 18.0];
	UIFont *font2 = [UIFont boldSystemFontOfSize: 18.0];
	UIFont *font0a = [UIFont boldSystemFontOfSize: 30.0];
	UIFont *font1a = [UIFont boldSystemFontOfSize: 25.0];
	UIFont *font2a = [UIFont boldSystemFontOfSize: 25.0];
	CGSize size0 = [string0 sizeWithFont: font0];
	CGPoint point0 = CGPointMake((w - size0.width) / 2 , size0
								 .height  + 40);
	CGContextRef c_string0 = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(c_string0, 0, 1, 0, 1);
	
	if (tapCount != 2){
		[image1 drawAtPoint: point1];
		[image2 drawAtPoint: point2];
		[string0 drawAtPoint: point0 withFont: font0];	
		[string1 drawAtPoint: point1 withFont: font1];
		[string2 drawAtPoint: point2 withFont: font2];
	} else if (tapCount == 2){
		[image1a drawAtPoint: point1];
		[image2a drawAtPoint: point2];
		[string0a drawAtPoint: point0 withFont: font0a];	
		[string1a drawAtPoint: point1 withFont: font1a];
		[string2a drawAtPoint: point2 withFont: font2a];
	}
	
}

@end
