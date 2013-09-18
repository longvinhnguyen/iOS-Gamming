//
//  Circle.m
//  CircleBall
//
//  Created by Long Vinh Nguyen on 9/18/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import "Circle.h"

@implementation Circle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    path.lineWidth = 2.0;
    [[UIColor redColor] setStroke];
    
    CGGradientRef circleGradient;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {
        0.0, 0.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 1.0
    };
    
    int numberLocations = 2;
    CGFloat locations[2] = {0.0, 1.0};
    
    circleGradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, numberLocations);
    [path addClip];
    CGContextDrawLinearGradient(context, circleGradient, CGPointMake(CGRectGetMidX(rect), 0), CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect)), 0);
    
    [path stroke];
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(circleGradient);
    CGContextRestoreGState(context);
    
}


@end
