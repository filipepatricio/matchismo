//
//  PlayingCard.m
//  Matchismo
//
//  Created by Filipe Patrício on 08/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString: self.suit];
}

+(NSArray *)validSuits
{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
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
