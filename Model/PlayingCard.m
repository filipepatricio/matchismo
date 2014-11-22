//
//  PlayingCard.m
//  Matchismo
//
//  Created by Filipe Patrício on 08/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    int totalCards = [otherCards count] + 1;
    
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
                score += 1;
            }else if (actualCard.rank == otherCard.rank){
                score += 4;
            }else{
                //no match
                noMatchCounter++;
            }
        }
    }
    
    if(noMatchCounter == 0){
        //if matchedCards number == otherCards number - means is a full match and has a 3 point Bonus
        NSLog(@"ALL MATCH - 3point bonus");
        score += 3;
    }
    else if(noMatchCounter < totalCards && noMatchCounter > 0){
        NSLog(@"%d match in %d cards", totalCards - noMatchCounter, totalCards);
    }else if(noMatchCounter == totalCards ){
        //no matched cards
        NSLog(@"NO MATCH");
    }
    
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
