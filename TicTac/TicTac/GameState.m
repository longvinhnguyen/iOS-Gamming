//
//  GameState.m
//  TicTac
//
//  Created by Long Vinh Nguyen on 9/21/13.
//  Copyright (c) 2013 Home Inc. All rights reserved.
//

#import "GameState.h"

@implementation GameState
@synthesize boardState, playersTurn;

- (id)init
{
    if (self = [super init]) {
        // Alloc and init the boardState
        boardState = [[NSMutableArray alloc] initWithCapacity:9];
        playersTurn = TToPlayerTurn;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:boardState forKey:@"BoardState"];
    [aCoder encodeInt:playersTurn forKey:@"PlayersTurn"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    boardState = [aDecoder decodeObjectForKey:@"BoardState"];
    playersTurn= [aDecoder decodeIntForKey:@"PlayersTurn"];
    
    return self;
}


@end
