//
//  WelcomeViewController.m
//  WoFiOS
//
//  Created by Tim.Milne on 2/26/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"

@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *wheel;

@end

// The global appDelegate class
AppDelegate *appDelegate;

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    // Let's start some music
    if (appDelegate == nil) appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate playSound:@"wof_theme"];
    
    // Translate the wheel
    CABasicAnimation* translationAnimation;
    translationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    translationAnimation.fromValue = [NSNumber numberWithFloat:300];
    translationAnimation.toValue = [NSNumber numberWithFloat:0];
    translationAnimation.duration = 2;
    translationAnimation.cumulative = YES;
    translationAnimation.repeatCount = 1;
    [self.wheel.layer addAnimation:translationAnimation forKey:@"translationAnimation"];

    // Spin the wheel - this one has a nice start and finish
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:4];
    [UIView setAnimationBeginsFromCurrentState:YES];
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
    self.wheel.transform = transform;
    
    [UIView commitAnimations];
    
/*
    // Spin the wheel - this one keeps spinning
    [UIView animateWithDuration:5.0f delay:0.0f options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.wheel setTransform:CGAffineTransformRotate([self.wheel transform], M_PI-0.00001f)];
                     } completion:nil];
*/
    
/*
    // Spin the wheel - this one only spins a couple times
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    rotationAnimation.duration = 5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = -1;
    
    [self.wheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
*/

    // TPM To dos
    // Set up the gesture recognizer and the segue in the storyboard (done)
    // Lock the orientation to portrait, or rework the constraints to work in both (done)
    // Enter the puzzle and pass it via the segue (done)
    // Program the guesser with dings (done)
    // Oh, and add all the sounds... (done, and done again)
    // So, functionally it's all done, jazz it up a little
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
