//
//  ViewController.m
//  TicTac
//
//  Created by Long Vinh Nguyen on 9/21/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate, GKPeerPickerControllerDelegate>

@end

@implementation ViewController
@synthesize spaceButton, theGameState, xImage, oImage, myPeerID, myUUID, theSession, myShape;

- (void)viewDidLoad
{
    [super viewDidLoad];
    xImage = [UIImage imageNamed:@"x.png"];
    oImage = [UIImage imageNamed:@"o.png"];
    
    theGameState = [[GameState alloc] init];
    
    myShape = TTMyShapeUndetermined;
    myUUID = [self getUUIDString];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initGame];
}

- (void)viewDidAppear:(BOOL)animated
{
    GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;
    [picker show];
}

- (void)initGame
{
    self.theGameState.playersTurn = TTxPlayerTurn;
    self.statusLabel.text = @"X to move";
    [self.theGameState.boardState removeAllObjects];
    
    for (int i = 0; i<= 8; i++) {
        [self.theGameState.boardState insertObject:@" " atIndex:i];
    }
    
    [self updateBoard];
}

- (void)updateBoard
{
    [self.theGameState.boardState enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *state = (NSString *)obj;
        if ([state isEqualToString:@"x"]) {
            [spaceButton[idx] setImage:xImage forState:UIControlStateNormal];
        } else if ([state isEqualToString:@"o"]) {
            [spaceButton[idx] setImage:oImage forState:UIControlStateNormal];
        } else {
            [spaceButton[idx] setImage:nil forState:UIControlStateNormal];
        }
    }];
}

- (BOOL)didPlayerWin:(NSString *)player
{
    if ( ([self.theGameState.boardState[0] isEqualToString:player] && [self.theGameState.boardState[1] isEqualToString:player] && [self.theGameState.boardState[2] isEqualToString:player])
        || ([self.theGameState.boardState[0] isEqualToString:player] && [self.theGameState.boardState[3] isEqualToString:player] && [self.theGameState.boardState[6] isEqualToString:player])
        || ([self.theGameState.boardState[0] isEqualToString:player] && [self.theGameState.boardState[4] isEqualToString:player] && [self.theGameState.boardState[8] isEqualToString:player])
        || ([self.theGameState.boardState[1] isEqualToString:player] && [self.theGameState.boardState[4] isEqualToString:player] && [self.theGameState.boardState[7] isEqualToString:player])
        || ([self.theGameState.boardState[3] isEqualToString:player] && [self.theGameState.boardState[4] isEqualToString:player] && [self.theGameState.boardState[5] isEqualToString:player])
        || ([self.theGameState.boardState[6] isEqualToString:player] && [self.theGameState.boardState[7] isEqualToString:player] && [self.theGameState.boardState[8] isEqualToString:player])
        || ([self.theGameState.boardState[2] isEqualToString:player] && [self.theGameState.boardState[5] isEqualToString:player] && [self.theGameState.boardState[8] isEqualToString:player])
        || ([self.theGameState.boardState[2] isEqualToString:player] && [self.theGameState.boardState[4] isEqualToString:player] && [self.theGameState.boardState[6] isEqualToString:player])) {
        return YES;
    }
    
    return NO;
}

- (TTGameOverStatus)checkGameOverStatus
{
    if ([self didPlayerWin:@"x"]) {
        return TTGameOverxWins;
    } else if ([self didPlayerWin:@"o"]) {
        return TTGameOveroWins;
    }
    
    for (NSString *state in self.theGameState.boardState) {
        if ([state isEqualToString:@" "]) {
            return TTGameNotOver;
        }
    }
    
    return TTGameOverTie;
}

- (void)updateGameStatus
{
    // Check for win or tie
    TTGameOverStatus gameOverStatus = [self checkGameOverStatus];
    
    switch (gameOverStatus) {
        case TTGameNotOver:
            if (self.theGameState.playersTurn == TTxPlayerTurn) {
                self.statusLabel.text = @"X to move";
            } else if (self.theGameState.playersTurn == TToPlayerTurn) {
                self.statusLabel.text = @"O to move";
            }
            break;
        case TTGameOverxWins:
        case TTGameOveroWins:
        case TTGameOverTie:
            [self endGameWithResult:gameOverStatus];
            
        default:
            break;
    }
}

- (void)endGameWithResult:(TTGameOverStatus)result
{
    NSString *gameOverMessage;
    switch (result) {
        case TTGameOverxWins:
            gameOverMessage = @"X Wins";
            break;
        case TTGameOveroWins:
            gameOverMessage = @"O Wins";
            break;
        case TTGameOverTie:
            gameOverMessage = @"The game is tie.";
            break;
            
        default:
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:gameOverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self initGame];
}

- (NSString *)getUUIDString
{
    NSString *result;
    CFUUIDRef uuid;
    CFStringRef uuidString;
    
    uuid = CFUUIDCreate(NULL);
    uuidString = CFUUIDCreateString(NULL, uuid);
    
    result = [NSString stringWithFormat:@"%@", uuidString];
    
    CFRelease(uuid);
    CFRelease(uuidString);
    
    return result;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action method
- (IBAction)spaceButtonTapped:(UIButton *)sender
{
    int spaceIndex = sender.tag;
    
    if ([self.theGameState.boardState[spaceIndex] isEqualToString:@" "] && self.theGameState.playersTurn == self.myShape) {
        if (self.theGameState.playersTurn == TTxPlayerTurn) {
            [self.theGameState.boardState replaceObjectAtIndex:spaceIndex withObject:@"x"];
            self.theGameState.playersTurn = TToPlayerTurn;
        } else {
            [self.theGameState.boardState replaceObjectAtIndex:spaceIndex withObject:@"o"];
            self.theGameState.playersTurn = TTxPlayerTurn;
        }
    }
    
    [self updateBoard];
    [self updateGameStatus];
    
    // Send the new game state out to peers
    NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:self.theGameState];
    NSError *error;
    
    [self.theSession sendDataToAllPeers:theData withDataMode:GKSendDataReliable error:&error];
}

#pragma mark - GKPeerPickerViewController delegate
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    self.theSession = session;
    
    self.myPeerID = peerID;
    [session setDataReceiveHandler:self withContext:nil];
    
    [picker dismiss];
    
    // session is connected so negotiate shapes
    // Send out UUID
    NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:self.myUUID];
    NSError *error;
    [self.theSession sendDataToAllPeers:theData withDataMode:GKSendDataReliable error:&error];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    NSLog(@"Received data");
    
    if (myShape == TTMyShapeUndetermined) {
        NSString *peerUUID = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([myUUID compare:peerUUID] == NSOrderedAscending) {
            myShape = TTMyShapeX;
            self.statusLabel.text = @"You are X";
        } else {
            myShape = TTMyShapeO;
            self.statusLabel.text = @"You are O";
        }
    } else {
        self.theGameState = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self updateBoard];
        [self updateGameStatus];
    }
}



@end
