//
//  TopicTests.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <XCTest/XCTest.h>


@class Topic;

@interface TopicTests : XCTestCase {
    Topic *topic;
}
@end

#import "Topic.h"
#import "Question.h"

@implementation TopicTests

- (void)setUp
{
    topic = [[Topic alloc] initWithName:@"iphone" tag:@"iphone"];
}

- (void)tearDown
{
    topic = nil;
}

- (void)testThatTopicsExist {
    XCTAssertNotNil(topic, @"should be able to create topic instance");
}

- (void)testThatTopicCanBeNamed {
    XCTAssertEqualObjects(topic.name, @"iphone", @" the topic should have the name i give it");
}

- (void)testThatTopicHasATag {
    XCTAssertEqualObjects(topic.tag, @"iphone", @"topics need to have tags");
}

- (void)testForAListOfQuestions {
    XCTAssertTrue([[topic recentQuestions] isKindOfClass:[NSArray class]], @"topics should provide a list of recent questions");
}

- (void)testForInitiallyEmptyQuestionList {
    XCTAssertEqual([[topic recentQuestions] count] , (NSUInteger)0, @"no questions added yet, count should be zero");
}

- (void)testAddingAQuestionToTheList {
    Question *question = [[Question alloc] init];
    [topic addQuestion:question];
    XCTAssertEqual([[topic recentQuestions] count], (NSUInteger)1, @"add a question, and the count of questions should go up");
}

- (void)testQuestionsAreListedChronologically {
    Question *q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [topic addQuestion:q1];
    [topic addQuestion:q2];
    
    NSArray *questions = [topic recentQuestions];
    Question *listedFirst = questions[0];
    Question *listedSecond = questions[1];
    
    XCTAssertEqualObjects([listedFirst.date laterDate:listedSecond.date], listedFirst.date, @"the later question should appear first on the list");
}



- (void)testLimitOfTwentyQuestion {
    Question *q1 = [[Question alloc] init];
    for (NSInteger i = 0; i < 25; i++) {
        [topic addQuestion:q1];
    }
    XCTAssertTrue([[topic recentQuestions] count] < 21, @"there should never be more than twenty quesitons");
}



@end
