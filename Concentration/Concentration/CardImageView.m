//
//  CardImageView.m
//  Concentration
//
//  Created by Long Vinh Nguyen on 9/17/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import "CardImageView.h"

@implementation CardImageView
@synthesize faceDown,value;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame value:(int)inValue
{
    if (self = [super initWithFrame:frame]) {
        self.value = inValue;
        self.faceDown = YES;
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"Card_Back.png"];
    }
    
    return self;
}


- (void)flipCard
{
    if (self.faceDown) {
        NSString *frontFileName = [NSString stringWithFormat:@"Card Front_%i", self.value];
        self.image = [UIImage imageNamed:frontFileName];
        self.faceDown = NO;
    } else {
        self.image = [UIImage imageNamed:@"Card_Back.png"];
        self.faceDown = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
