//
//  ViewController.m
//  Concentration
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
    [self createCards];
    
    firstTappedView = nil;
    isAnimating = NO;
}

- (void)createCards
{
    NSMutableArray *cards = [[NSMutableArray alloc] initWithCapacity:64];
    
    for (int i = 1;  i<=16; i++) {
        for (int j = 1; j<=4; j++) {
            [cards addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    // Shuffle Cards
    srandom(time( NULL ));
    int swapA, swapB;
    
    for (int i = 0; i < 10000; i++) {
        swapA = (random() % 64);
        swapB = (random() % 64);
        
        NSNumber *tempNumber = [cards objectAtIndex:swapA];
        [cards replaceObjectAtIndex:swapA withObject:cards[swapB]];
        [cards replaceObjectAtIndex:swapB withObject:tempNumber];
    }
    
    [self addCardsToView:cards];
    
}

- (void)addCardsToView:(NSMutableArray *)cards
{
    CardImageView *card;
    CGRect cardFrame;
    CGRect cardOrigin = CGRectMake(0, 0, 40, 60);
    
    cardFrame.size = CGSizeMake(40, 60);
    CGPoint origin;
    int cardIndex = 0;
    
    NSTimeInterval timeDelay = 0.0;
    
    for (int i = 0; i<8; i++) {
        for (int j = 0; j<8; j++) {
            origin.x = i*50 + 100;
            origin.y = j*70 +100;
            cardFrame.origin = origin;
            
            // Create the card at the origin
            card = [[CardImageView alloc] initWithFrame:cardOrigin value:[[cards objectAtIndex:cardIndex] intValue]];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTapsRequired = 1;
            [card addGestureRecognizer:tap];
            
            [self.view addSubview:card];
            
            // Animate moving the card into position
            [UIView animateWithDuration:0.5 delay:timeDelay options:UIViewAnimationOptionCurveLinear animations:^{
                card.frame = cardFrame;
            } completion:nil];
            
            timeDelay += 0.1;
            cardIndex ++;
        }
    }
    
}

- (void)flipCards
{
    [UIView transitionWithView:firstTappedView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [firstTappedView flipCard];
    } completion:nil];
    [UIView transitionWithView:secondTappedView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [secondTappedView flipCard];
    } completion:^(BOOL finished) {
        isAnimating = NO;
    }];
    
    firstTappedView = nil;
    secondTappedView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIGestureRecognizer methods
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    if (isAnimating)
        return;
    
    CardImageView *tappedCard = (CardImageView *)gestureRecognizer.view;
    // Has the card already first tapped?
    if (firstTappedView == nil) {
        [UIView transitionWithView:tappedCard duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [tappedCard flipCard];
        } completion:nil];
        firstTappedView = tappedCard;
    } else if (firstTappedView != tappedCard) {
        isAnimating = YES;
        
        [UIView transitionWithView:tappedCard duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            [tappedCard flipCard];
        } completion:nil];
        
        // test for a match
        if (firstTappedView.value == tappedCard.value) {
            // Player found a match
            // Remove the cards
            [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionTransitionNone animations:^{
                firstTappedView.alpha = 0;
                tappedCard.alpha = 0;
            } completion:^(BOOL finished) {
                [firstTappedView removeFromSuperview];
                [tappedCard removeFromSuperview];
                isAnimating = NO;
            }];
            
            firstTappedView = nil;
        } else {
            // Flip both cards back over
            secondTappedView = tappedCard;
            [self performSelector:@selector(flipCards) withObject:nil afterDelay:2];
        }
    }
}



@end
