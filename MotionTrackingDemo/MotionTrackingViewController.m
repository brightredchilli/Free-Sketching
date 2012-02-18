//
//  MotionTrackingViewController.m
//  MotionTrackingDemo
//
//  Created by Krishna Ramachandran on 2/7/12.
//  Copyright (c) 2012 11 Under llc. All rights reserved.
//

#import "MotionTrackingViewController.h"
#import <QuartzCore/CoreAnimation.h>


@implementation MotionTrackingViewController

@synthesize imageView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self drawSquiggly:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark Squiggly gesture recognizer

- (void)drawFreeformLineHandler:(UIPanGestureRecognizer *)sender {
  
  
  if (sender.state == UIGestureRecognizerStateBegan) {

    if (!freeformLayer) {
      freeformLineDrawer = [[FreeformLineDrawer alloc] initWithStartPoint:[sender locationInView:self.view]];
      freeformLayer = [[CALayer alloc] init];
      freeformLayer.frame = self.view.frame;
      freeformLayer.delegate = freeformLineDrawer;
      [self.view.layer addSublayer:freeformLayer];
      NSLog(@"layer created");
    }
   
  }
  
  if (sender.state == UIGestureRecognizerStateChanged) {
    //start drawin lines baby...
    [freeformLineDrawer updatePoint:[sender locationInView:self.view]];
    [freeformLayer setNeedsDisplay];
    NSLog(@"layer updated");
    
  }
}

#pragma mark -
#pragma mark Pan Gesture Recognizer 

- (IBAction)drawSquiggly:(id)sender {
  [freeformLayer removeFromSuperlayer];
  freeformLayer = nil;
  freeformLineDrawer = nil;
  [self.view removeGestureRecognizer:panGestureRecognizer]; //remove old recognizer if it exists
  panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drawFreeformLineHandler:)];
  [self.view addGestureRecognizer:panGestureRecognizer];

}


@end
