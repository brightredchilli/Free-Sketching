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
    pathsSet = CFArrayCreateMutable(NULL, 2, &kCFTypeArrayCallBacks); 
    [self startNewPoint:startPoint];
    
  }
  return self;
}
- (void)startNewPoint:(CGPoint)newPoint {
  previousPoint1 = previousPoint2 = currentPoint = newPoint;
  
  if (pathRef) {
    CGPathRelease(pathRef);
  }
  
  pathRef = CGPathCreateMutable();
  CFArrayAppendValue(pathsSet, pathRef);
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
  
  CGPathMoveToPoint(pathRef, NULL, mid1.x, mid1.y);
  CGPathAddQuadCurveToPoint(pathRef, NULL, previousPoint1.x, previousPoint1.y, mid2.x, mid2.y);
  
  CGContextSetLineCap(ctx, kCGLineCapRound);    
  CGContextSetLineWidth(ctx, 5.0);    
  CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);    
  CGContextStrokePath(ctx);    

  
  for (CFIndex i = 0; i < CFArrayGetCount(pathsSet); i++) {
    CGContextAddPath(ctx, CFArrayGetValueAtIndex(pathsSet, i));
  }
  CGContextDrawPath(ctx, kCGPathStroke);
}

- (void)dealloc {
  CFRelease(pathsSet);
  CGPathRelease(pathRef);
}

@end
