//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Filipe Patrício on 12/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; //of Card
@property (nonatomic)NSUInteger matchNumber;
@property (nonatomic, strong)NSMutableArray *chosenCards;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    // Lazy instantiation!
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *)chosenCards
{
    // Lazy instantiation!
    if(!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self)
    {
        for(int i = 0; i<count; i++){
                Card  *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject: card];
            }else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return index<[self.cards count] ? [self.cards objectAtIndex:index]: nil;
}

static const int CHOSEN_PENALTY = 1;
static const int MISMATCH_PENALTY = 2;
static const int BONUS_MATCH = 4;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = false;
        }else{
            //match against other chosen cards
            for(Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    [self.chosenCards addObject:card];
                    if([self.chosenCards count] == self.matchNumber-1){
                        int matchScore = [card match:self.chosenCards];
                        if(matchScore){
                            self.score += BONUS_MATCH * matchScore;
                            [self matchChosenCards];
                            card.matched = true;
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            [self clearChosenCards];
                        }
                        self.chosenCards = nil;
                    }
                        
                    break;
                }
            }
            self.score -= CHOSEN_PENALTY;
            card.chosen = true;

        }
    }
}

-(void)matchChosenCards
{
    for(Card *card in self.chosenCards)
    {
        card.matched = true;
    }
}

-(void)clearChosenCards
{
    for(Card *card in self.chosenCards)
    {
        card.chosen = false;
    }
}

-(void)cardsMatchNumber:(NSUInteger)number
{
    self.matchNumber = number;
}

@end
