//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

@synthesize JSON;
@synthesize arrayToReturn;
@synthesize errorToSet;

- (NSArray *)questionsFromJSON: (NSString *)objectNotation
                         error: (NSError **)error {
    self.JSON = objectNotation;
    *error = errorToSet;
    return arrayToReturn;
}

@end