//
//  Deck.h
//  Matchismo
//
//  Created by Filipe Patrício on 08/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
