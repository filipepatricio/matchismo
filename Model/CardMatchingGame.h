//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Filipe Patrício on 12/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)cardsMatchNumber:(NSUInteger)number;

@property (nonatomic, readonly) NSInteger score;

@end
