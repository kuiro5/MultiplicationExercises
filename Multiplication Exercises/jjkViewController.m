//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 1
// Date: September 3, 2013
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

NSInteger correctAns = 0;           // correct answer to multiplication problem
NSInteger problemNum = 1;           // current problem number, start at 1
NSInteger numCorrectAns = 0;        // number of correct answers, start at 0
BOOL questionAns = NO;              // check if the answer has been answers to avoid multiple answers

- (void)newQuestion
{
    NSInteger tmpMultiplicand;          // multiplicand for current problem
    NSInteger tmpMultiplier;            // multiplicand for current problem
    NSInteger tmpAnswer;                // possible answer for current problem
    NSInteger tmpRand;                  // random variable to calculate tmpAnswer
    NSInteger arrayCnt = 0;             // current answers that have been added to answerArray
    BOOL evenCount = YES;               // used to radomize the +/- of tmpAnswer
    NSMutableArray *answerArray = [[NSMutableArray alloc] init];                // holds all possible answers for problem
    [_answerSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];       // unselect all answers on answerSegment
    self.answerStatusLabel.hidden = YES;                    // hide the answer until user selects it
    questionAns = NO;                                       // set the quesiton to be unanswered
    
    
    
    tmpMultiplicand = arc4random_uniform(14) + 1;               // random multiplicand from 1->15
    tmpMultiplier = arc4random_uniform(14) + 1;                 // random multiplie from 1->15
    
    self.multiplicandLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplicand];       // set multiplicand label
    self.multiplierLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplier];           // set multiplie label
    
    correctAns = tmpMultiplicand * tmpMultiplier;                           // calculate the correct answer
    NSNumber *tempNum = [NSNumber numberWithInt:correctAns];                // add correctAns to array of possible answers
    [answerArray addObject:tempNum];
    
    if(correctAns < 6)                          // avoid negative answers by only addding a rand number 1->5 for problems with a answer < 6
    {
        while(arrayCnt < 3)                         // continute to computate 3 wrong answers
        {
            tmpRand = arc4random_uniform(4) + 1;        // only add to avoid negative numbers
            
            tmpAnswer = correctAns + tmpRand;
            
            tempNum = [NSNumber numberWithInt:tmpAnswer];    // cast tmpAnswer to a NSNumber
            
            if(![answerArray containsObject:tempNum])       // check if answer exists
            {
                [answerArray addObject:tempNum];            // add answer to answerArray if its not a duplicate
                arrayCnt++;
            }
        }
    }
    else if(correctAns > 6)                                     // proceed normally for answers greater than 6
    {
        while(arrayCnt < 3)                                     // continute to computate 3 wrong answers
        {
            evenCount = (arc4random_uniform(50)%2==0);          // "randomize" the +/- difference of the wrong answer with the right answer
            tmpRand = arc4random_uniform(4) + 1;                // random offset 1->5
            
            if(evenCount == YES)                                // add or subtract offset based on randomness
                tmpAnswer = correctAns + tmpRand;
            else
                tmpAnswer = correctAns - tmpRand;
            
            tempNum = [NSNumber numberWithInt:tmpAnswer];       // cast tmpAnswer to NSNumber
            
            if(![answerArray containsObject:tempNum])           // add answer to answerArray if its not a duplicate
            {
                [answerArray addObject:tempNum];
                arrayCnt++;
            }
        }
    }
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [answerArray sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];                           // sort array to display answers in order
    
    for(int i = 0; i < 4; i++)
    {
        NSString *myString= [[answerArray objectAtIndex:i] stringValue];        // cast array object to string
        [_answerSegment setTitle:myString forSegmentAtIndex:i];                 // set title of segment in order from array
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
    self.resetButton.hidden = YES;                  // show reset button
    self.nextButton.hidden = NO;                    // hide next button
    problemNum = 0;                                 // reset problem number to 0
    numCorrectAns = 0;                              // reset number of correct answers to 0
    self.progressLabel.text = [NSString stringWithFormat:@"%d/%d", numCorrectAns, problemNum];     // set progress Label back to 0/0
    
    [self newQuestion];                             // initialize a new question
        
}

- (IBAction)startButtonPressed:(id)sender
{
    [self newQuestion];                                 // initialize a new question
    
    self.multiplicandLabel.hidden = NO;                 // show multiplicand
    self.multiplierLabel.hidden = NO;                   // show multiplier
    self.startButton.hidden = YES;                      // hide start button
    self.nextButton.hidden = NO;                        // show next button
    self.equalsLineView.hidden = NO;                    // show equals line
    self.answerSegment.hidden = NO;                     // show answer segmented control
    self.questionsCorrectLabel.hidden = NO;             // show questionsCorrectLabel
    self.progressLabel.hidden = NO;                     // show correct number/problem number

}

- (IBAction)nextButtonPressed:(id)sender
{
    
    if( problemNum == numberOfProbs )               // show reset button if the problem number gets to 10
    {
        self.resetButton.hidden = NO;
        self.nextButton.hidden = YES;
        
    }
    else
    {       
        self.answerLabel.hidden = YES;              // clear the label and init a new problem
        [self newQuestion];
    }
    
    problemNum++;                                   // increment the current problem num
    
    
}

- (IBAction)answerSelected:(id)sender
{
    if(!questionAns)                                // check to see if the question has been answer
    {
    NSString *answerSelected = [_answerSegment titleForSegmentAtIndex:_answerSegment.selectedSegmentIndex];         // get the answer the user selects
    
    self.answerLabel.hidden = NO;                   // show the answer
    self.answerLabel.text = answerSelected;         // set the answerLabel to the answerSelected
    
    NSInteger tempNum = [answerSelected intValue];  // number of the answer the user selects
    
    if( tempNum == correctAns)                      
    {
        self.answerStatusLabel.text = @"Correct";           // display Correct if the user chooses the correct answer
        self.answerStatusLabel.hidden = NO;
        numCorrectAns++;
        self.progressLabel.text = [NSString stringWithFormat:@"%d/%d", numCorrectAns, problemNum];      // set the progressLabel
        
    }
    else
    {
        self.answerStatusLabel.text = @"Incorrect";         // display Incorrect if the user chooses the incorrect answer
        self.answerStatusLabel.hidden = NO;
    
        self.progressLabel.text = [NSString stringWithFormat:@"%d/%d", numCorrectAns, problemNum];    //    set the progress label

    }
    }
    questionAns = YES;                  // set the question to be answered disabling future answering
}

@end
