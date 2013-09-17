//
//  ViewController.h
//  Concentration
//
//  Created by Long Vinh Nguyen on 9/17/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardImageView.h"

@interface ViewController : UIViewController
{
    CardImageView *firstTappedView;
    CardImageView *secondTappedView;
    bool isAnimating;
}

- (void)createCards;
- (void)addCardsToView:(NSMutableArray *) cards;
- (void)flipCards;

@end
