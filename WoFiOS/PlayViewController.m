//
//  PlayViewController.m
//  WoFiOS
//
//  Created by Tim.Milne on 2/26/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import "PlayViewController.h"
#import "DataClass.h" // Singleton data class
#import "AppDelegate.h"

@interface PlayViewController ()

// IBOutlet bindings
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *btnQ;
@property (weak, nonatomic) IBOutlet UIButton *btnW;
@property (weak, nonatomic) IBOutlet UIButton *btnE;
@property (weak, nonatomic) IBOutlet UIButton *btnR;
@property (weak, nonatomic) IBOutlet UIButton *btnT;
@property (weak, nonatomic) IBOutlet UIButton *btnY;
@property (weak, nonatomic) IBOutlet UIButton *btnU;
@property (weak, nonatomic) IBOutlet UIButton *btnI;
@property (weak, nonatomic) IBOutlet UIButton *btnO;
@property (weak, nonatomic) IBOutlet UIButton *btnP;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnS;
@property (weak, nonatomic) IBOutlet UIButton *btnD;
@property (weak, nonatomic) IBOutlet UIButton *btnF;
@property (weak, nonatomic) IBOutlet UIButton *btnG;
@property (weak, nonatomic) IBOutlet UIButton *btnH;
@property (weak, nonatomic) IBOutlet UIButton *btnJ;
@property (weak, nonatomic) IBOutlet UIButton *btnK;
@property (weak, nonatomic) IBOutlet UIButton *btnL;
@property (weak, nonatomic) IBOutlet UIButton *btnZ;
@property (weak, nonatomic) IBOutlet UIButton *btnX;
@property (weak, nonatomic) IBOutlet UIButton *btnC;
@property (weak, nonatomic) IBOutlet UIButton *btnV;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *btnN;
@property (weak, nonatomic) IBOutlet UIButton *btnM;

- (int)revealFoundLetters:(NSString *)letter;

@end

// The global data class
extern DataClass *data;

// The global appDelegate class
extern AppDelegate *appDelegate;

// Some colors
UIColor * red = nil;
UIColor * green = nil;
UIColor * black = nil;

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Start a new round
    if (appDelegate == nil) appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate playSound:@"wof_applause"];
    
    // Grab the data class
    if (data == nil) data = [DataClass getInstance:FALSE];
    
    // Configure the  button colors
    if (red   == nil) red   = [UIColor colorWithRed:200./255.0 green:0./255.0 blue:0./255.0 alpha:1.0];
    if (green == nil) green = [UIColor colorWithRed:0./255.0 green:200./255.0 blue:0./255.0 alpha:1.0];
    if (black == nil) black = [UIColor colorWithRed:0./255.0 green:0./255.0 blue:0./255.0 alpha:1.0];
    
    // Reveal the found letters
    [self revealFoundLetters:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)keypress:(UIButton *)sender {
    
    // Already guessed?
    if ([data.guessed[sender.titleLabel.text] isEqual: @"YES"]){
        [appDelegate playSound:@"wof_double_buzz"];
        return;
    }
    
    // Register the new guess
    [data.guessed setObject:@"YES" forKey:sender.titleLabel.text];
    int numFound = [self revealFoundLetters:sender.titleLabel.text];
    if (numFound > 0){
        // Play a ding for each letter found
        [appDelegate removeQueuedSounds];
        for (int i=0; i<numFound; i++) {
            [appDelegate queueSound:@"wof_ding"];
        }
        [appDelegate playQueuedSounds];
    }
    else {
        [appDelegate playSound:@"wof_buzz"];
    }
    
    // Disable this button (this works, but disabled for now
//    [sender setUserInteractionEnabled:false];
}

- (int)revealFoundLetters:(NSString *) letter {
    
    // Find the number with a search and replace
    int numFound = 0;
    if (letter != nil){
        NSMutableString *tmp = [[NSMutableString alloc] initWithString:data.puzzle];
        numFound = [tmp replaceOccurrencesOfString:letter withString:@"-" options:NSBackwardsSearch range:NSMakeRange(0, [tmp length])];
    }
    
    // Set up the puzzle board - changing all the unguessed letters for dashes
    NSUInteger length = [data.puzzle length];
    unichar buffer[length+1];
    [data.puzzle getCharacters:buffer range:NSMakeRange(0, length)];
    [data.puzzleBoard setString:@""];
    for (int i = 0; i < length; i++)
    {
        NSString *str = [[NSString alloc] initWithFormat:@"%c", buffer[i]];
        [data.puzzleBoard appendString:([str isEqualToString:@" "])?@" ":([[data.guessed objectForKey:str] isEqualToString:@"YES"])?str:@"-"];
    }
    
    // Set the colors of all the buttons
    [self.btnA setTitleColor:([[data.guessed objectForKey:@"A"] isEqualToString:@"YES"])?([data.puzzle containsString:@"A"]?green:red):black forState:UIControlStateNormal];
    [self.btnB setTitleColor:([[data.guessed objectForKey:@"B"] isEqualToString:@"YES"])?([data.puzzle containsString:@"B"]?green:red):black forState:UIControlStateNormal];
    [self.btnC setTitleColor:([[data.guessed objectForKey:@"C"] isEqualToString:@"YES"])?([data.puzzle containsString:@"C"]?green:red):black forState:UIControlStateNormal];
    [self.btnD setTitleColor:([[data.guessed objectForKey:@"D"] isEqualToString:@"YES"])?([data.puzzle containsString:@"D"]?green:red):black forState:UIControlStateNormal];
    [self.btnE setTitleColor:([[data.guessed objectForKey:@"E"] isEqualToString:@"YES"])?([data.puzzle containsString:@"E"]?green:red):black forState:UIControlStateNormal];
    [self.btnF setTitleColor:([[data.guessed objectForKey:@"F"] isEqualToString:@"YES"])?([data.puzzle containsString:@"F"]?green:red):black forState:UIControlStateNormal];
    [self.btnG setTitleColor:([[data.guessed objectForKey:@"G"] isEqualToString:@"YES"])?([data.puzzle containsString:@"G"]?green:red):black forState:UIControlStateNormal];
    [self.btnH setTitleColor:([[data.guessed objectForKey:@"H"] isEqualToString:@"YES"])?([data.puzzle containsString:@"H"]?green:red):black forState:UIControlStateNormal];
    [self.btnI setTitleColor:([[data.guessed objectForKey:@"I"] isEqualToString:@"YES"])?([data.puzzle containsString:@"I"]?green:red):black forState:UIControlStateNormal];
    [self.btnJ setTitleColor:([[data.guessed objectForKey:@"J"] isEqualToString:@"YES"])?([data.puzzle containsString:@"J"]?green:red):black forState:UIControlStateNormal];
    [self.btnK setTitleColor:([[data.guessed objectForKey:@"K"] isEqualToString:@"YES"])?([data.puzzle containsString:@"K"]?green:red):black forState:UIControlStateNormal];
    [self.btnL setTitleColor:([[data.guessed objectForKey:@"L"] isEqualToString:@"YES"])?([data.puzzle containsString:@"L"]?green:red):black forState:UIControlStateNormal];
    [self.btnM setTitleColor:([[data.guessed objectForKey:@"M"] isEqualToString:@"YES"])?([data.puzzle containsString:@"M"]?green:red):black forState:UIControlStateNormal];
    [self.btnN setTitleColor:([[data.guessed objectForKey:@"N"] isEqualToString:@"YES"])?([data.puzzle containsString:@"N"]?green:red):black forState:UIControlStateNormal];
    [self.btnO setTitleColor:([[data.guessed objectForKey:@"O"] isEqualToString:@"YES"])?([data.puzzle containsString:@"O"]?green:red):black forState:UIControlStateNormal];
    [self.btnP setTitleColor:([[data.guessed objectForKey:@"P"] isEqualToString:@"YES"])?([data.puzzle containsString:@"P"]?green:red):black forState:UIControlStateNormal];
    [self.btnQ setTitleColor:([[data.guessed objectForKey:@"Q"] isEqualToString:@"YES"])?([data.puzzle containsString:@"Q"]?green:red):black forState:UIControlStateNormal];
    [self.btnR setTitleColor:([[data.guessed objectForKey:@"R"] isEqualToString:@"YES"])?([data.puzzle containsString:@"R"]?green:red):black forState:UIControlStateNormal];
    [self.btnS setTitleColor:([[data.guessed objectForKey:@"S"] isEqualToString:@"YES"])?([data.puzzle containsString:@"S"]?green:red):black forState:UIControlStateNormal];
    [self.btnT setTitleColor:([[data.guessed objectForKey:@"T"] isEqualToString:@"YES"])?([data.puzzle containsString:@"T"]?green:red):black forState:UIControlStateNormal];
    [self.btnU setTitleColor:([[data.guessed objectForKey:@"U"] isEqualToString:@"YES"])?([data.puzzle containsString:@"U"]?green:red):black forState:UIControlStateNormal];
    [self.btnV setTitleColor:([[data.guessed objectForKey:@"V"] isEqualToString:@"YES"])?([data.puzzle containsString:@"V"]?green:red):black forState:UIControlStateNormal];
    [self.btnW setTitleColor:([[data.guessed objectForKey:@"W"] isEqualToString:@"YES"])?([data.puzzle containsString:@"W"]?green:red):black forState:UIControlStateNormal];
    [self.btnX setTitleColor:([[data.guessed objectForKey:@"X"] isEqualToString:@"YES"])?([data.puzzle containsString:@"X"]?green:red):black forState:UIControlStateNormal];
    [self.btnY setTitleColor:([[data.guessed objectForKey:@"Y"] isEqualToString:@"YES"])?([data.puzzle containsString:@"Y"]?green:red):black forState:UIControlStateNormal];
    [self.btnZ setTitleColor:([[data.guessed objectForKey:@"Z"] isEqualToString:@"YES"])?([data.puzzle containsString:@"Z"]?green:red):black forState:UIControlStateNormal];

    // Sync the text field
    [self.textField setSelectable:YES]; // This to overcome a font size bug
    [self.textField setText:(data.puzzleBoard)];
    [self.textField setSelectable:NO];
    
    return numFound;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Ok, we are about to go back to the setup screen, so the round must be won.
    // Instead of using this, I set up an unwind segue in the calling View Controller
    // called roundComplete and hooked the swipe gesture to this method.
 }
*/


@end
