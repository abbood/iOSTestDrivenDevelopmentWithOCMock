//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"
@class Topic;
@class QuestionBuilder;

extern NSString *StackOverflowManagerSearchFailedError;
enum {
    StackOverflowManagerErrorQuestionSearchCode
};

@protocol StackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError: (NSError *)error;

@end





@interface StackOverflowManager : NSObject

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;


@end
