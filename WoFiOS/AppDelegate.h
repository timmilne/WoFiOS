//
//  AppDelegate.h
//  WoFiOS
//
//  Created by Tim.Milne on 2/26/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// The old way, for a single sound, using the AVAudioPlayer
- (void)playSound:(NSString *)audioFile;

// The new way, for a queued list of sounds, using the AVQueuePlayer
- (void)removeQueuedSounds;
- (void)queueSound:(NSString *)audioFile;
- (void)playQueuedSounds;

@property (strong, nonatomic) UIWindow *window;

// Declare the objects for the audio players
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) AVQueuePlayer *queuePlayer;

@end

