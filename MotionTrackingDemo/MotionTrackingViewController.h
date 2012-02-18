//
//  MotionTrackingViewController.h
//  MotionTrackingDemo
//
//  Created by Krishna Ramachandran on 2/7/12.
//  Copyright (c) 2012 11 Under llc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeformLineDrawer.h"
#import <QuartzCore/QuartzCore.h>

@interface MotionTrackingViewController : UIViewController {
    
 
@private
  CALayer *freeformLayer;
  UIPanGestureRecognizer *panGestureRecognizer;
  FreeformLineDrawer *freeformLineDrawer;
}

@property (nonatomic, assign) IBOutlet UIImageView *imageView;

- (IBAction)drawSquiggly:(id)sender;

@end
