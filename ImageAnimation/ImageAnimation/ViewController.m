//
//  ViewController.m
//  ImageAnimation
//
//  Created by Long Vinh Nguyen on 9/17/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *animatedImages = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.view addSubview:animatedImages];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:10];
    NSString *fileName;
    
    for (int i = 1; i<=10; i++) {
        fileName = [NSString stringWithFormat:@"Clock%i.png", i];
        [imageArray addObject:[UIImage imageNamed:fileName]];
    }
    
    // Configure animations
    animatedImages.animationImages = imageArray;
    animatedImages.animationDuration = 1;

    [animatedImages startAnimating];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
