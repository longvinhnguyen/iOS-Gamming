//
//  ViewController.m
//  CircleBall
//
//  Created by Long Vinh Nguyen on 9/18/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    circleView = [[Circle alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [self.view addSubview:circleView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    CGPoint previousLocation = [touch previousLocationInView:self.view];
    
    CGPoint translation = CGPointMake(touchLocation.x - previousLocation.x, touchLocation.y - previousLocation.y);
    CGRect frame = circleView.frame;
    frame.origin.x += translation.x;
    frame.origin.y += translation.y;
    circleView.frame = frame;
}

@end
