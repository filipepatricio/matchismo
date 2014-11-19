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
#import "CardMatchingGame.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (nonatomic) int flipCount;
@property (strong, nonatomic)Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@end


@implementation ViewController

-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[self createDeck]];
    return _game;
}

@synthesize deck = _deck;

- (IBAction)cardTouch:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
    self.gameModeControl.enabled = false;
    
}

-(void) newGame
{
    self.game = nil;
    [self setGameMode];
    [self updateUI];
}

-(void) setGameMode
{
    [self.game cardsMatchNumber:[self.gameModeControl selectedSegmentIndex] + 2];
}

- (IBAction)setGameModeAction:(UISegmentedControl *)sender
{
    [self setGameMode];
}

- (IBAction)newGameAction:(UIButton *)sender
{
    [self newGame];
    self.gameModeControl.enabled = true;
}


-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card =[self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents: @"";
}

-(UIImage *)imageForCard:(Card *)card
{
    return  [UIImage imageNamed: card.isChosen ? @"cardFront" : @"cardBack"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self newGame];
    
}

-(Deck *)deck
{
    if(!_deck) [self createDeck];
    return _deck;
}

-(Deck *)createDeck
{
    _deck = [[PlayingCardDeck alloc]init];
    return _deck;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
