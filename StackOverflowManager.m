//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "StackOverflowManager.h"
#import "Topic.h"
#import "QuestionBuilder.h"

NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";

@implementation StackOverflowManager

@synthesize delegate;
@synthesize questionBuilder;

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate {
    if (newDelegate &&
        ![newDelegate conformsToProtocol:
          @protocol(StackOverflowManagerDelegate)]) {
            [[NSException exceptionWithName: NSInvalidArgumentException
                                     reason: @"Delegate object does not conform to the delegate protocol"
                                   userInfo: nil] raise];
        }
    delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    [self.communicator searchForQuestionsWithTag: [topic tag]];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject: error
                                                          forKey: NSUnderlyingErrorKey];
    NSError *reportableError = [NSError
                                errorWithDomain: StackOverflowManagerSearchFailedError
                                code: StackOverflowManagerErrorQuestionSearchCode
                                userInfo:errorInfo];
    [delegate fetchingQuestionsFailedWithError:reportableError];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError *error = nil;
    NSArray *questions = [questionBuilder
                          questionsFromJSON: objectNotation error: &error];
    if (!questions) {
        NSDictionary *errorInfo = nil;
        if (error) {
            errorInfo = [NSDictionary dictionaryWithObject: error
                                                    forKey: NSUnderlyingErrorKey];
        }
        NSError *reportableError = [NSError
                                    errorWithDomain: StackOverflowManagerSearchFailedError
                                    code: StackOverflowManagerErrorQuestionSearchCode
                                    userInfo: errorInfo];
        [delegate fetchingQuestionsFailedWithError: reportableError];
    }
}

@end
