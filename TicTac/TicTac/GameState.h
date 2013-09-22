//
//  GameState.h
//  TicTac
//
//  Created by Long Vinh Nguyen on 9/21/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TTxPlayerTurn = 1,
    TToPlayerTurn = 2
}TTPlayerTurn;

@interface GameState : NSObject<NSCoding>
{
    TTPlayerTurn playersTurn;
    NSMutableArray *boardState;
}

@property (nonatomic, assign) TTPlayerTurn playersTurn;
@property (nonatomic, strong) NSMutableArray *boardState;

@end
