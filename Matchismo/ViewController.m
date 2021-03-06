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
@property (weak, nonatomic) IBOutlet UILabel *eventsLabel;
@property (weak, nonatomic) IBOutlet UISlider *eventsSlider;
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
    self.eventsSlider.value = self.eventsSlider.maximumValue;
    
}

-(void) newGame
{
    self.game = nil;
    [self setGameMode];
    [self updateUI];
}

- (IBAction)deal {
    // ask to confirm re-dealing
    UIAlertView *warning = [[UIAlertView alloc] initWithTitle:@"Re-deal"
                                                      message:@"Are you sure you want to re-deal the deck and start over?"
                                                     delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles:@"Yes", nil];
    [warning show];
}

// handle alert view confirmation
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
        [self newGame];
    }
}

-(void) setGameMode
{
    [self.game cardsMatchNumber:[self.gameModeControl selectedSegmentIndex]];
}

- (IBAction)setGameModeAction:(UISegmentedControl *)sender
{
    [self setGameMode];
}

- (IBAction)newGameAction:(UIButton *)sender
{
    [self deal];
    self.gameModeControl.enabled = true;
    
}

- (IBAction)eventChanger:(UISlider *)sender {
    int value = roundf( (([[self.game eventsArray]count]-1) * sender.value) / sender.maximumValue);
    NSLog(@"maximum value: %f - sender value: %f - real value: %d", sender.maximumValue, sender.value, value);
    self.eventsLabel.text = [self.game eventsArray][value];
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
    self.eventsLabel.text = [[self.game eventsArray] lastObject];
    self.eventsSlider.enabled = [[self.game eventsArray] count] > 0;
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
