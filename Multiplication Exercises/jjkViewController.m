//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 1
// Date: September 3, 2013
//

#import "jjkViewController.h"
#define numberOfProbs 10

@interface jjkViewController ()
@property (weak, nonatomic) IBOutlet UILabel *multiplicationLabel;

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

NSInteger correctAns = 0;
NSInteger problemNum = 1;
NSInteger numCorrectAns = 0;        


- (void)newQuestion
{
    NSInteger tmpMultiplicand;
    NSInteger tmpMultiplier;
    NSInteger tmpAnswer;
    NSInteger tmpRand;
    NSInteger arrayCnt = 0;
    BOOL evenCount = YES;               // used to radomize the +/- of tmpAnswer
    NSMutableArray *answerArray = [[NSMutableArray alloc] init];                // holds all possible answers for problem
    [_answerSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    self.answerStatusLabel.hidden = YES;
    self.answerSegment.enabled = YES;                       
    self.nextButton.enabled = NO;
    
    
    tmpMultiplicand = arc4random_uniform(14) + 1;
    tmpMultiplier = arc4random_uniform(14) + 1;                 
    
    self.multiplicandLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplicand];
    self.multiplierLabel.text = [NSString stringWithFormat:@"%d", tmpMultiplier];
    
    correctAns = tmpMultiplicand * tmpMultiplier;
    NSNumber *tempNum = [NSNumber numberWithInt:correctAns];                
    [answerArray addObject:tempNum];
    
    if(correctAns < 6)                          // avoid negative answers by only addding a rand number 1->5 for problems with a answer < 6
    {
        while(arrayCnt < 3)                         // continute to computate 3 wrong answers
        {
            tmpRand = arc4random_uniform(4) + 1;        // only add to avoid negative numbers
            
            tmpAnswer = correctAns + tmpRand;
            
            tempNum = [NSNumber numberWithInt:tmpAnswer];    // cast tmpAnswer to a NSNumber
            
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
            evenCount = (arc4random_uniform(50)%2==0);          // "randomize" the +/- difference of the wrong answer with the right answer
            tmpRand = arc4random_uniform(4) + 1;                // random offset 1->5
            
            if(evenCount == YES)                                // add or subtract offset based on randomness
                tmpAnswer = correctAns + tmpRand;
            else
                tmpAnswer = correctAns - tmpRand;
            
            tempNum = [NSNumber numberWithInt:tmpAnswer];       // cast tmpAnswer to NSNumber
            
            if(![answerArray containsObject:tempNum])
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
    numCorrectAns = 0;                              
    self.progressLabel.text = [NSString stringWithFormat:@"%d/%d", numCorrectAns, problemNum];     // set progress Label back to 0/0
    
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
    self.multiplicationLabel.hidden = NO;

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
        self.answerLabel.hidden = YES;
        [self newQuestion];
    }
    
    problemNum++;                                  
    
    
}

- (IBAction)answerSelected:(id)sender
{
    NSString *answerSelected = [_answerSegment titleForSegmentAtIndex:_answerSegment.selectedSegmentIndex];         // get the answer the user selects
    
    self.answerLabel.text = answerSelected;
    self.answerLabel.hidden = NO;                   
    
    
    NSInteger tempNum = [answerSelected intValue];          // number of the answer the user selects
    
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
    
    self.answerSegment.enabled = NO;
    self.nextButton.enabled = YES;
    
}

@end
