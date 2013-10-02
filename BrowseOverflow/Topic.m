//
//  Topic.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@implementation Topic {
    NSArray *questions;
}

@synthesize name;
@synthesize tag;

- (id)initWithName:(NSString *)newName tag:(NSString *)newTag {
    if ((self = [super init])) {
        name = [newName copy];
        tag = [newTag copy];
        questions = [[NSArray alloc] init];
    }
    
    return self;
}

- (void)addQuestion: (Question *)question {
    NSArray *newQuestions = [questions arrayByAddingObject: question];
    if ([newQuestions count] >20) {
        newQuestions = [self sortQuestionsLatestFirst: newQuestions];
        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0,20)];
    }
    questions = newQuestions;
}

- (NSArray *)recentQuestions {
    return [self sortQuestionsLatestFirst: questions];
    
}

- (NSArray *)sortQuestionsLatestFirst: (NSArray *)questionList {
    return [questions sortedArrayUsingComparator:^(id obj1, id obj2) {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        
        return [q2.date compare:q1.date];
    }];
}




@end
