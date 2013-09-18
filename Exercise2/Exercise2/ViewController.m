//
//  ViewController.m
//  Exercise2
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
    UIImage *image = [UIImage imageNamed:@"starship.gif"];
    starShip = [[CALayer alloc] init];
    starShip.contents = (__bridge id)[image CGImage];
    starShip.anchorPoint = CGPointZero;
    starShip.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [self.view.layer addSublayer:starShip];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleTap:(UIGestureRecognizer *)gesture
{
    CGPoint tapPoint = [gesture locationInView:self.view];
    starShip.position = tapPoint;
}

@end
