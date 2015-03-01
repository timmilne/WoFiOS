//
//  AppDelegate.m
//  WoFiOS
//
//  Created by Tim.Milne on 2/26/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// Play the specified sound right now (non blocking)
- (void)playSound:(NSString *)audioFile {
    
    // This one uses the AVAudioPlayer
    NSString * audioFilePath = [[NSBundle mainBundle] pathForResource:audioFile ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    
    // Init the audio player.
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:pathAsURL error:&error];
    
    // Check out what's wrong in case that the player doesn't init.
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If everything is fine, just play.
        [self.player play];
    }
}

// Remove all sounds in the queue
- (void)removeQueuedSounds{
    if (self.queuePlayer != nil) [self.queuePlayer removeAllItems];
}

// Queue a new sound
- (void)queueSound:(NSString *)audioFile {
    
    //This one uses the AVQueuePlayer
    NSString * audioFilePath = [[NSBundle mainBundle] pathForResource:audioFile ofType:@"mp3"];
    NSURL *pathAsURL = [[NSURL alloc] initFileURLWithPath:audioFilePath];
    AVPlayerItem * item = [[AVPlayerItem alloc] initWithURL:pathAsURL];
    if (self.queuePlayer == nil) {
        self.queuePlayer = [[AVQueuePlayer alloc] initWithURL:pathAsURL];
    }
    else {
        [self.queuePlayer insertItem:item afterItem:nil];
    }
}

// Play all queued sounds (also nonblocking, and concurrent with playSound)
- (void)playQueuedSounds {
    if (self.queuePlayer != nil) [self.queuePlayer play];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
