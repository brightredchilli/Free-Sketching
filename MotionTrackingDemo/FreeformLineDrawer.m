//
//  FreeformLineDrawer.m
//  MotionTrackingDemo
//
//  Created by Ying Quan Tan on 2/17/12.
//  Copyright (c) 2012 11 Under llc. All rights reserved.
//

#import "FreeformLineDrawer.h"
#import <QuartzCore/QuartzCore.h>

CGPoint midPoint(CGPoint p1, CGPoint p2)
{    
  return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

@implementation FreeformLineDrawer 

- (id)initWithStartPoint:(CGPoint)startPoint {
  
  self = [super init];
  if (self) {
    previousPoint1 = previousPoint2 = currentPoint = startPoint;
    pathRef = CGPathCreateMutable();
  }
  return self;
}

- (void)updatePoint:(CGPoint)newPoint {
  previousPoint2 = previousPoint1;
  previousPoint1 = currentPoint;    
  currentPoint = newPoint;
  
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
  // calculate mid point    
  CGPoint mid1 = midPoint(previousPoint1, previousPoint2);     
  CGPoint mid2 = midPoint(currentPoint, previousPoint1);    
  //UIGraphicsBeginImageContext(self.imageView.frame.size);    
  //CGContextRef context = UIGraphicsGetCurrentContext();    
//  [self.imageView.image drawInRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)]; 
 
  CGContextMoveToPoint(ctx, mid1.x, mid1.y);    
  
  // Use QuadCurve is the key    
//  CGAffineTransformMake(1, 0, 0, 1, 0, 0)
  CGPathAddQuadCurveToPoint(pathRef, &CGAffineTransformIdentity, previousPoint1.x, previousPoint1.y, mid2.x, mid2.y);
//  CGContextAddQuadCurveToPoint(ctx, previousPoint1.x, previousPoint1.y, mid2.x, mid2.y);     
  CGContextSetLineCap(ctx, kCGLineCapRound);    
  CGContextSetLineWidth(ctx, 2.0);    
  CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);    
  CGContextStrokePath(ctx);    
  CGContextAddPath(ctx, pathRef);
  CGContextDrawPath(ctx, kCGPathFill);
  NSLog(@"**********DRAW LAYER*****************");
  
  //self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();    
  //UIGraphicsEndImageContext();
}


@end
