//
//  ViewController.m
//  RepeatIt
//
//  Created by Long Vinh Nguyen on 9/18/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import "ViewController.h"

#define IMAGE_SIZE  140
#define SPACING     10

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load images
    [self loadImages];
    
    playingSequence = NO;
    
    sequence = [[NSMutableArray alloc] initWithCapacity:100];
    
    srandom(time( NULL ));
    
    NSURL *sound0URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"0" ofType:@"aiff"]];
    audioPlayer0 = [[AVAudioPlayer alloc] initWithContentsOfURL:sound0URL error:nil];
    
    NSURL *sound1URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"aiff"]];
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:sound1URL error:nil];
    
    NSURL *sound2URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"aiff"]];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:sound2URL error:nil];
    
    NSURL *sound3URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"aiff"]];
    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:sound3URL error:nil];
    
    // set up delegates
    audioPlayer0.delegate = self;
    audioPlayer1.delegate = self;
    audioPlayer2.delegate = self;
    audioPlayer3.delegate = self;
    
    // Prepare to play sound
    [audioPlayer0 prepareToPlay];
    [audioPlayer1 prepareToPlay];
    [audioPlayer2 prepareToPlay];
    [audioPlayer3 prepareToPlay];
    
    // Configure the audio session
    NSError *setCategoryErr = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryErr];
    
    [self addToSequence];
    
    [self playSequence];
    
}

- (void)loadImages
{
    image0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"0_light.png"] highlightedImage:[UIImage imageNamed:@"0.png"]];
    image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1_light.png"] highlightedImage:[UIImage imageNamed:@"1.png"]];
    image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2_light.png"] highlightedImage:[UIImage imageNamed:@"2.png"]];
    image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3_light.png"] highlightedImage:[UIImage imageNamed:@"3.png"]];
    
    CGRect position = CGRectMake(0, 0, IMAGE_SIZE, IMAGE_SIZE);
    image0.frame = position;
    [self.view addSubview:image0];
    
    position = CGRectMake(IMAGE_SIZE + SPACING, 0, IMAGE_SIZE, IMAGE_SIZE);
    image1.frame = position;
    [self.view addSubview:image1];
    
    position = CGRectMake(0, IMAGE_SIZE + SPACING, IMAGE_SIZE, IMAGE_SIZE);
    image2.frame = position;
    [self.view addSubview:image2];
    
    position = CGRectMake(IMAGE_SIZE + SPACING, IMAGE_SIZE + SPACING, IMAGE_SIZE, IMAGE_SIZE);
    image3.frame = position;
    [self.view addSubview:image3];
    
    // Enable touch on images
    image0.userInteractionEnabled = YES;
    image1.userInteractionEnabled = YES;
    image2.userInteractionEnabled = YES;
    image3.userInteractionEnabled = YES;
    
    image0.tag = 0;
    image1.tag = 1;
    image2.tag = 2;
    image3.tag = 3;
    
    
}

- (void)addToSequence
{
    int randomNum = (random() % 4);
    [sequence addObject:@(randomNum)];
}

- (void)playSequence
{
    // reset the button counter
    buttonCounter = 0;
    
    playingSequence = YES;
    
    // Play the first button
    [self playButton:[[sequence objectAtIndex:buttonCounter] intValue]];
}

- (void)playButton:(int)buttonNumber
{
    switch (buttonNumber) {
        case 0:
            image0.highlighted = YES;
            audioPlayer0.currentTime = 0;
            [audioPlayer0 play];
            break;
        case 1:
            image1.highlighted = YES;
            audioPlayer1.currentTime = 0;
            [audioPlayer1 play];
            break;
        case 2:
            image2.highlighted = YES;
            audioPlayer2.currentTime = 0;
            [audioPlayer2 play];
            break;
        case 3:
            image3.highlighted = YES;
            audioPlayer3.currentTime = 0;
            [audioPlayer3 play];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // User needs to repeat the sequence
    
    if (!playingSequence && buttonCounter < [sequence count]) {
        UITouch *touch = [touches anyObject];
        
        if ([touch.view class] == [UIImageView class]) {
            UIImageView *tappedView = (UIImageView *)touch.view;
            
            [self playButton:tappedView.tag];
            
            int correctButton = [[sequence objectAtIndex:buttonCounter] intValue];
            
            if (tappedView.tag == correctButton) {
                buttonCounter ++;
                
                if ([sequence count] == buttonCounter) {
                    [self performSelector:@selector(playerFinished) withObject:nil afterDelay:2.0f];
                }
            } else {
                [self endGameWithMessage:@"You missed"];
            }
        }
    }
}

- (void)playerFinished
{
    [self addToSequence];
    
    [self playSequence];
}

- (void)endGameWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [sequence removeAllObjects];
    buttonCounter = 0;
    [self addToSequence];
    
    [self playSequence];
}



#pragma mark - Audio Player delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)completed
{
    if (completed) {
        //
        
        NSString *urlString = [player.url lastPathComponent];
        if ([urlString isEqualToString:@"0.aiff"]) {
            image0.highlighted = NO;
        } else if ([urlString isEqualToString:@"1.aiff"]) {
            image1.highlighted = NO;
        } else if ([urlString isEqualToString:@"2.aiff"]) {
            image2.highlighted = NO;
        } else if ([urlString isEqualToString:@"3.aiff"]) {
            image3.highlighted = NO;
        }
        
        if (playingSequence) {
            // Increment the button counter and see if we are finished
            if (++buttonCounter<[sequence count]) {
                [self playButton:[[sequence objectAtIndex:buttonCounter] intValue]];
            }  else {
                buttonCounter = 0;
                playingSequence = NO;
            }
        }
    }
}












@end
