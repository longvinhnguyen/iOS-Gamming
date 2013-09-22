//
//  ViewController.h
//  TicTac
//
//  Created by Long Vinh Nguyen on 9/21/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameState.h"

typedef enum {
    TTGameNotOver = 0,
    TTGameOverxWins = 1,
    TTGameOveroWins = 2,
    TTGameOverTie = 3
}TTGameOverStatus;

typedef enum {
    TTMyShapeUndetermined = 0,
    TTMyShapeX = 1,
    TTMyShapeO = 2
}TTMyShape;

@interface ViewController : UIViewController
{
    UIImage *xImage;
    UIImage *oImage;
    
    GameState *theGameState;
    
    // Which player am I
    TTMyShape myShape;
    NSString *myUUID;
    
    // GameKit variables
    GKSession *theSession;
    NSString *myPeerID;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *spaceButton;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong) UIImage *xImage;
@property (nonatomic, strong) UIImage *oImage;
@property (nonatomic, strong) GameState *theGameState;

@property (nonatomic, strong) NSString *myUUID;
@property (nonatomic, strong) GKSession *theSession;
@property (nonatomic, strong) NSString * myPeerID;
@property (nonatomic, assign) TTMyShape myShape;

- (void)initGame;
- (void)updateBoard;
- (void)updateGameStatus;
- (TTGameOverStatus)checkGameOverStatus;
- (BOOL)didPlayerWin:(NSString *)player;
- (void)endGameWithResult:(TTGameOverStatus)result;
- (NSString *)getUUIDString;

@end
