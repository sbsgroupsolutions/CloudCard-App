//
//  InitialSlidingViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/25/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    
  [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}

@end
