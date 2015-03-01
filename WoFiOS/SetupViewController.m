//
//  SetupViewController.m
//  WoFiOS
//
//  Created by Tim.Milne on 2/26/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import "SetupViewController.h"
#import "DataClass.h" // Singleton data class
#import "AppDelegate.h"

@interface SetupViewController ()

// IBOutlet bindings
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *btnPause;

@end

// The global data class
extern DataClass *data;

// The global appDelegate class
extern AppDelegate *appDelegate;

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (appDelegate == nil) appDelegate = [[UIApplication sharedApplication] delegate];

    // Grab the data class
    if (data == nil) data=[DataClass getInstance:TRUE];
    
    // Sync the text field
    [self.textField setSelectable:YES]; // This to overcome a font size bug
    [self.textField setText:(data.puzzle)];
    [self.textField setSelectable:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)keypress:(UIButton *)sender {

    // Stop the music
    if ([sender.titleLabel.text compare:@"Pause Music"] == NSOrderedSame) {
        [appDelegate.player pause];
        [appDelegate.queuePlayer pause];
        [sender setTitle:@"Play Music" forState:UIControlStateNormal];
        return;
    }
    
    // Play the music
    else if ([sender.titleLabel.text compare:@"Play Music"] == NSOrderedSame) {
        [appDelegate playSound:@"wof_theme"];
        [sender setTitle:@"Pause Music" forState:UIControlStateNormal];
        return;
    }

    // Clear the puzzle
    if ([sender.titleLabel.text compare:@"Clear"] == NSOrderedSame){
        [DataClass getInstance:TRUE];
    }
    
    // Add the space
    else if ([sender.titleLabel.text compare:@"Space"] == NSOrderedSame){
        [data.puzzle appendString:@" "];
    }
    
    // Backspace
    else if ([sender.titleLabel.text compare:@"Bksp"] == NSOrderedSame){
        [data.puzzle deleteCharactersInRange:NSMakeRange([data.puzzle length]-1, 1)];
    }
    
    // Add the letter on the button label
    else {
        [data.puzzle appendString:sender.titleLabel.text];
    }
    
    // Sync with textField
    [self.textField setSelectable:YES]; // This to overcome a font size bug
    [self.textField setText:(data.puzzle)];
    [self.textField setSelectable:NO];
}

- (IBAction)roundComplete:(UIStoryboardSegue*)segue {
    
    // This unwind action is invoked by the swipe down gesture recognizer in the Play View Controller.
    // AVQueuePlayer is just the ticket to play a sequence of non-blocking sounds.
    // You can even send the first sound to playSound, and it will play in concert.
    [appDelegate playSound:@"wof_final_spin"];
    [appDelegate removeQueuedSounds];
    [appDelegate queueSound:@"wof_applause"];
    [appDelegate queueSound:@"wof_theme"];
    [appDelegate playQueuedSounds];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Let's kill all the playing sounds
    [appDelegate.player pause];
    [appDelegate.queuePlayer pause];
}


@end
