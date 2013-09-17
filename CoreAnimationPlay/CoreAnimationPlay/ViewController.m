//
//  ViewController.m
//  CoreAnimationPlay
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
    
    // Configure gesture recognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    // Set the backgroundImage by setting the contents of the view's layer
    UIImage *bg = [UIImage imageNamed:@"Background.png"];
    self.view.layer.contents = (__bridge id)([bg CGImage]);
    
    // Set the alternate varible
    alternate = YES;
    
    // Add ship layers
    [self addShipLayers];
}

- (void)addShipLayers
{
    // Add layers for each space ship
    UIImage *shipImage = [UIImage imageNamed:@"SpaceShip_1.png"];
    ship1 = [[CALayer alloc] init];
    ship1.frame = CGRectMake(0, 0, SHIP1_WIDTH/3, SHIP1_HEIGHT/3);
    ship1.contents = (id)[shipImage CGImage];
    
    shipImage = [UIImage imageNamed:@"SpaceShip_2.png"];
    ship2 = [[CALayer alloc] init];
    ship2.frame = CGRectMake(0, 50, SHIP2_WIDTH/3, SHIP2_HEIGHT/3);
    ship2.contents = (id)[shipImage CGImage];
    
    shipImage = [UIImage imageNamed:@"SpaceShip_3.png"];
    ship3 = [[CALayer alloc] init];
    ship3.frame = CGRectMake(0, 100, SHIP3_WIDTH/3, SHIP2_HEIGHT/3);
    ship3.contents = (id)[shipImage CGImage];
    
    // Add ship1 layer to view's layer
    [self.view.layer addSublayer:ship1];
    
    // Add ship 2 and ship 3 as sublayers of ship 1
    [ship1 addSublayer:ship2];
    [ship1 addSublayer:ship3];
    
}

- (void)handleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (alternate) {
        ship1.anchorPoint = CGPointZero;
        ship1.position = CGPointMake(150, 200);
    } else {
        [self returnShipsToDefaultState];
    }
    
    alternate = !alternate;
}

- (void)returnShipsToDefaultState
{
    ship1.position = CGPointZero;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
