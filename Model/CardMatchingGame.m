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
@property (nonatomic, readwrite, strong)NSMutableArray *eventsArray; //of Strings
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
-(NSMutableArray *)eventsArray
{
    if(!_eventsArray) _eventsArray = [[NSMutableArray alloc] init];
    return _eventsArray;
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
            [self.eventsArray addObject:[NSString stringWithFormat:@"%@ Unpicked", card.contents]];
        }else{
            //create a new chosen cards Array
            self.chosenCards = nil;
            
            //match against other chosen cards
            for(Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    //add chosen card
                    [self.chosenCards addObject:otherCard];
                }
            }
            
            //self.matchNumber + 1 because of SegmentControlUI
            if([self.chosenCards count] == (self.matchNumber+1)){
                int matchScore = [card match:self.chosenCards];
                if(matchScore){
                    self.score += BONUS_MATCH * matchScore;
                    [self matchChosenCards];
                    card.matched = true;
                }else{
                    self.score -= MISMATCH_PENALTY;
                    [self clearChosenCards];
                }
                
            }else{
                [self.eventsArray addObject:[NSString stringWithFormat:@"%@ Picked", card.contents]];
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
