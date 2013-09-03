//
//  jjkViewController.m
//  Multiplication Exercises
//
//  Created by Joshua Kuiros on 9/2/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkViewController.h"

@interface jjkViewController ()
@property (weak, nonatomic) IBOutlet UILabel *multiplicandLabel;
@property (weak, nonatomic) IBOutlet UILabel *multiplierLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *answerSegment;
@property (weak, nonatomic) IBOutlet UIView *equalsLineView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)answerSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *questionsCorrectLabel;


@end

@implementation jjkViewController

- (void)newQuestion
{
    NSInteger tmpMultiplicand;
    NSInteger tmpMultiplier;
    NSInteger answerOne;
    NSInteger answerTwo;
    NSInteger answerThree;
    NSInteger answerFour;
    
    tmpMultiplicand = arc4random_uniform(14) + 1;
    tmpMultiplier = arc4random_uniform(14) + 1;
    
    self.multiplicandLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplicand];
    self.multiplierLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplier];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender
{
    //[newQuestion];
    
    
    /*NSInteger tmpMultiplicand;
    NSInteger tmpMultiplier;
    NSInteger answerOne;
    NSInteger answerTwo;
    NSInteger answerThree;
    NSInteger answerFour;
    
    tmpMultiplicand = arc4random_uniform(14) + 1;
    tmpMultiplier = arc4random_uniform(14) + 1;
    
    self.multiplicandLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplicand];
    self.multiplierLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplier];*/
    
    [self newQuestion];
    
    self.multiplicandLabel.hidden = NO;
    self.multiplierLabel.hidden = NO;
    self.startButton.hidden = YES;
    self.nextButton.hidden = NO;
    self.equalsLineView.hidden = NO;
    self.answerSegment.hidden = NO;
    self.questionsCorrectLabel.hidden = NO;
    self.progressLabel.hidden = NO;
}

- (IBAction)nextButtonPressed:(id)sender {
    
    /*NSInteger tmpMultiplicand;
    NSInteger tmpMultiplier;
    NSInteger answerOne;
    NSInteger answerTwo;
    NSInteger answerThree;
    NSInteger answerFour;
    
    tmpMultiplicand = arc4random_uniform(14) + 1;
    tmpMultiplier = arc4random_uniform(14) + 1;
    
    self.multiplicandLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplicand];
    self.multiplierLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplier];*/
    
    [self newQuestion];
}

- (IBAction)answerSelected:(id)sender {
}

@end
