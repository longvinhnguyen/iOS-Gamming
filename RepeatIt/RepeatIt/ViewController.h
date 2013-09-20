//
//  ViewController.h
//  RepeatIt
//
//  Created by Long Vinh Nguyen on 9/18/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate>
{
    UIImageView *image0;
    UIImageView *image1;
    UIImageView *image2;
    UIImageView *image3;
    
    // Track if a sequence is playing
    BOOL playingSequence;
    
    // The computer buttons' sequence
    NSMutableArray *sequence;
    
    // The audio players
    AVAudioPlayer *audioPlayer0;
    AVAudioPlayer *audioPlayer1;
    AVAudioPlayer *audioPlayer2;
    AVAudioPlayer *audioPlayer3;
    
    int buttonCounter;
}

- (void) loadImages;
- (void) addToSequence;
- (void) playSequence;
- (void) playButton:(int) buttonNumber;
- (void) endGameWithMessage:(NSString *)message;
- (void) playerFinished;

@end
