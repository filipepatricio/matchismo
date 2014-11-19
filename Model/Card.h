//
//  Card.h
//  Matchismo
//
//  Created by Filipe Patrício on 08/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
