//
//  ViewController.m
//  Matchismo
//
//  Created by Filipe Patrício on 08/11/14.
//  Copyright (c) 2014 Filipe Patrício. All rights reserved.
//

#import "ViewController.h"

#import "Deck.H"
#import "PlayingCardDeck.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic)Deck *deck;
@end


@implementation ViewController

@synthesize deck = _deck;

-(void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips Counter: %d", flipCount];
    //NSLog(self.flipsLabel.text);
}

- (IBAction)cardTouch:(UIButton *)sender {
    
    if([sender.currentTitle length]){
        [sender setTitle:@"" forState:UIControlStateNormal ];
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                          forState:UIControlStateNormal];
            self.flipCount++;
    }else{
        Card *card = [self.deck drawRandomCard];
        
        if(card){
            [sender setTitle:card.contents forState:UIControlStateNormal ];
            [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
                              forState:UIControlStateNormal];
                self.flipCount++;
        }
        
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(Deck *)deck
{
    if(!_deck)
        [self createDeck];
    
    return _deck;
}

-(void)createDeck
{
    _deck = [[PlayingCardDeck alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
