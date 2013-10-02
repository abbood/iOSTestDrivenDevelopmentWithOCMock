//
//  Question.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "Question.h"
#import "Answer.h"

@implementation Question

@synthesize date;
@synthesize title;
@synthesize score;

- (id)init {
    if ((self = [super init])) {
        answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer {
    [answerSet addObject: answer];
}

- (NSArray *)answers {
    return [[answerSet allObjects]
            sortedArrayUsingSelector: @selector(compare:)];
}

@end
