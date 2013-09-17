//
//  CardImageView.h
//  Concentration
//
//  Created by Long Vinh Nguyen on 9/17/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardImageView : UIImageView
{
    BOOL faceDown;
    int value;
}

- (id)initWithFrame:(CGRect)frame value:(int)value;
- (void)flipCard;

@property (nonatomic, assign) BOOL faceDown;
@property (nonatomic, assign) int value;

@end
