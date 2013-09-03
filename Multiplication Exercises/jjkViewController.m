//
//  jjkViewController.m
//  Multiplication Exercises
//
//  Created by Joshua Kuiros on 9/2/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkViewController.h"
#define numberOfProbs 10

@interface jjkViewController ()
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UILabel *multiplicandLabel;
@property (weak, nonatomic) IBOutlet UILabel *multiplierLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *answerSegment;
@property (weak, nonatomic) IBOutlet UIView *equalsLineView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *questionsCorrectLabel;
- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)answerSelected:(id)sender;

@end

@implementation jjkViewController

NSInteger correctAns;
NSInteger problemNum=1;
NSInteger numCorrectAns = 0;
BOOL questionAns = NO;

- (void)newQuestion
{
    NSInteger tmpMultiplicand;
    NSInteger tmpMultiplier;
    NSInteger answerOne;
    NSInteger answerTwo;
    NSInteger answerThree;
    NSInteger tempRand;
    NSInteger arrayCnt = 0;
    BOOL evenCount = YES;
    NSMutableArray *answerArray = [[NSMutableArray alloc] init];
    [_answerSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    self.answerStatusLabel.hidden = YES;
    questionAns = NO;
    
    
    
    tmpMultiplicand = arc4random_uniform(14) + 1;
    tmpMultiplier = arc4random_uniform(14) + 1;
    
    self.multiplicandLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplicand];
    self.multiplierLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplier];
    
    correctAns = tmpMultiplicand * tmpMultiplier;
    NSNumber *tempNum = [NSNumber numberWithInt:correctAns];
    [answerArray addObject:tempNum];
    
    if(correctAns < 6)
    {
        while(arrayCnt < 3)
        {
            evenCount = (arc4random_uniform(50)%2==0);
            tempRand = arc4random_uniform(4) + 1;
            
            if(evenCount == YES)
                answerOne = correctAns + tempRand;
            else
                answerOne = correctAns - tempRand;
            
            tempNum = [NSNumber numberWithInt:answerOne];
            
            if(![answerArray containsObject:tempNum])
            {
                [answerArray addObject:tempNum];
                arrayCnt++;
            }
        }
    }
    else if(correctAns > 6)
    {
        while(arrayCnt < 3)
        {
            evenCount = (arc4random_uniform(50)%2==0);
            tempRand = arc4random_uniform(4) + 1;
            
            if(evenCount == YES)
                answerOne = correctAns + tempRand;
            else
                answerOne = correctAns - tempRand;
            
            tempNum = [NSNumber numberWithInt:answerOne];
            
            if(![answerArray containsObject:tempNum])
            {
                [answerArray addObject:tempNum];
                arrayCnt++;
            }
        }
    }
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [answerArray sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    
    for(int i = 0; i < 4; i++)
    {
        NSString *myString= [[answerArray objectAtIndex:i] stringValue];
        [_answerSegment setTitle:myString forSegmentAtIndex:i];
    }
    
    
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

- (IBAction)resetButtonPressed:(id)sender
{
    self.resetButton.hidden = YES;
    self.nextButton.hidden = NO;
    problemNum = 0;
    
    [self newQuestion];
    
}

- (IBAction)startButtonPressed:(id)sender
{
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

- (IBAction)nextButtonPressed:(id)sender
{
    self.answerLabel.hidden = YES;
   
    if( problemNum == numberOfProbs )
    {
        self.resetButton.hidden = NO;
        self.nextButton.hidden = YES;
        
    }
    else
    {
        [self newQuestion];
    }
    
    problemNum++;
    
    
}

- (IBAction)answerSelected:(id)sender
{
    if(!questionAns)
    {
    NSString *answerSelected = [_answerSegment titleForSegmentAtIndex:_answerSegment.selectedSegmentIndex];
    
    self.answerLabel.hidden = NO;
    self.answerLabel.text = answerSelected;
    
    NSInteger tempNum = [answerSelected intValue];
    
    if( tempNum == correctAns)
    {
        self.answerStatusLabel.text = @"Correct";
        self.answerStatusLabel.hidden = NO;
        numCorrectAns++;
        self.progressLabel.text = [NSString stringWithFormat:@"%d/%d", numCorrectAns, problemNum];
        
    }
    else
    {
        self.answerStatusLabel.text = @"Incorrect";
        self.answerStatusLabel.hidden = NO;
    
        self.progressLabel.text = [NSString stringWithFormat:@"%d/%d", numCorrectAns, problemNum];

    }
    }
    questionAns = YES;
}

@end
