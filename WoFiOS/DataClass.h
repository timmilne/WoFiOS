//
//  DataClass.h
//  WoFiOS
//
//  Created by Tim.Milne on 2/27/15.
//  Copyright (c) 2015 Tim.Milne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject {
    NSMutableString *puzzle;
    NSMutableString *puzzleBoard;
    NSMutableDictionary *guessed;
}

@property (nonatomic, retain) NSMutableString *puzzle;
@property (nonatomic, retain) NSMutableString *puzzleBoard;
@property (nonatomic, retain) NSMutableDictionary *guessed;

+(DataClass*)getInstance:(BOOL)reset;

@end
