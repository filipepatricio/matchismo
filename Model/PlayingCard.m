//
//  PlayingCard.m
//  Matchismo
//
//  Created by Filipe Patrício on 08/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()
@property (nonatomic, strong) NSMutableArray *eventHistory;
@end

@implementation PlayingCard


static const int SUIT_MATCH_POINT = 1;
static const int RANK_MATCH_POINT = 4;
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    int totalCards = [otherCards count] + 1;
    
    NSMutableArray *eventHistory = [[NSMutableArray alloc] init];
    
//    if([otherCards count]==1)
//    {
//        PlayingCard *otherCard= [otherCards firstObject];
//        if([self.suit isEqualToString: otherCard.suit]){
//            score = 1;
//        }else if (self.rank == otherCard.rank){
//            score = 4;
//        }
//    }
    
    unsigned int noMatchCounter = 0;
    
    NSMutableArray *matchedCards = [[NSMutableArray alloc] initWithArray:otherCards]; //of PlayingCards
    [matchedCards addObject:self];
    
    while([matchedCards count] > 0){
        PlayingCard *actualCard = [matchedCards lastObject];
        [matchedCards removeLastObject];
        for(int i = 0; i<[matchedCards count]; i++){
            PlayingCard *otherCard = matchedCards[i];
            if([actualCard.suit isEqualToString: otherCard.suit]){
                score += SUIT_MATCH_POINT;
                [eventHistory addObject:[NSString stringWithFormat:@"%@ match with %@ for %d points", actualCard.contents, otherCard.contents, SUIT_MATCH_POINT]];
            }else if (actualCard.rank == otherCard.rank){
                score += RANK_MATCH_POINT;
                [eventHistory addObject:[NSString stringWithFormat:@"%@ match with %@ for %d points", actualCard.contents, otherCard.contents, RANK_MATCH_POINT]];
            }else{
                //no match
                noMatchCounter++;
            }
        }
    }
    
    if(noMatchCounter == 0){
        //if matchedCards number == otherCards number - means is a full match and has a 3 point Bonus
        [eventHistory addObject: @"ALL MATCH - 3 point bonus"];
        score += 3;
    }
    else if(noMatchCounter < totalCards && noMatchCounter > 0){
        [eventHistory addObject: [NSString stringWithFormat:@"%d match in %d cards", totalCards - noMatchCounter, totalCards]];
    }else if(noMatchCounter == totalCards ){
        //no matched cards
        [eventHistory addObject: @"NO MATCH"];
    }
    
    self.eventHistory = eventHistory;
    
    return score;
}

-(NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString: self.suit];
}

+(NSArray *)validSuits
{
    return @[@"❤️",@"♦️",@"♠️",@"♣️"];
}

@synthesize suit = _suit; //because we provide getter AND setter

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit :@"?"; //return _suit, or if _suit == nil returns "?"
}

+(NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSUInteger)maxRank
{
    return[[self rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank])
        _rank = rank;
}

@end
