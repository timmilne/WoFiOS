//
//  DataClass.m
//  WoFiOS
//
//  Created by Tim.Milne on 2/27/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass

@synthesize puzzle;
@synthesize puzzleBoard;
@synthesize guessed;

// The global data class
DataClass *data = nil;

static DataClass *instance = nil;

+(DataClass *)getInstance:(BOOL)reset {
    @synchronized(self){
        if(instance==nil){
            instance = [DataClass new];
            instance.puzzle = [[NSMutableString alloc] init];
            [instance.puzzle capitalizedString];
            instance.puzzleBoard = [[NSMutableString alloc] init];
            [instance.puzzleBoard capitalizedString];
            instance.guessed = [[NSMutableDictionary alloc] init];
            reset = TRUE;
        }
        if (reset == TRUE){
            [instance.puzzle setString:@""];
            [instance.puzzleBoard setString:@""];
            [instance.guessed setObject:@"NO" forKey: @"A"];
            [instance.guessed setObject:@"NO" forKey: @"B"];
            [instance.guessed setObject:@"NO" forKey: @"C"];
            [instance.guessed setObject:@"NO" forKey: @"D"];
            [instance.guessed setObject:@"NO" forKey: @"E"];
            [instance.guessed setObject:@"NO" forKey: @"F"];
            [instance.guessed setObject:@"NO" forKey: @"G"];
            [instance.guessed setObject:@"NO" forKey: @"H"];
            [instance.guessed setObject:@"NO" forKey: @"I"];
            [instance.guessed setObject:@"NO" forKey: @"J"];
            [instance.guessed setObject:@"NO" forKey: @"K"];
            [instance.guessed setObject:@"NO" forKey: @"L"];
            [instance.guessed setObject:@"NO" forKey: @"M"];
            [instance.guessed setObject:@"NO" forKey: @"N"];
            [instance.guessed setObject:@"NO" forKey: @"O"];
            [instance.guessed setObject:@"NO" forKey: @"P"];
            [instance.guessed setObject:@"NO" forKey: @"Q"];
            [instance.guessed setObject:@"NO" forKey: @"R"];
            [instance.guessed setObject:@"NO" forKey: @"S"];
            [instance.guessed setObject:@"NO" forKey: @"T"];
            [instance.guessed setObject:@"NO" forKey: @"U"];
            [instance.guessed setObject:@"NO" forKey: @"V"];
            [instance.guessed setObject:@"NO" forKey: @"W"];
            [instance.guessed setObject:@"NO" forKey: @"X"];
            [instance.guessed setObject:@"NO" forKey: @"Y"];
            [instance.guessed setObject:@"NO" forKey: @"Z"];
            [instance.guessed setObject:@"YES" forKey: @" "]; // This is always yes
        }
    }
    return instance;
}

@end
