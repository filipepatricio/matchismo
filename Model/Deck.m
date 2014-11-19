//
//  Deck.m
//  Matchismo
//
//  Created by Filipe Patrício on 08/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property(strong, nonatomic)NSMutableArray *cards; //of Card
@end

@implementation Deck

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init]; // "lazy instantiation" because it delays initialization till it is called
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }else
    {
        [self.cards addObject:card];
    }
    
}
-(void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if([self.cards count]){
        int index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}


@end
