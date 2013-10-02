//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface QuestionTests : XCTestCase

@end

#import "Question.h"
@implementation QuestionTests {
    Question *question;
}

- (void)setUp
{
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"do iphones also dream of electric sheep?";
    question.score = 42;
}

- (void)tearDown
{
    question = nil;
}

- (void)testQuestionHasADate {
    NSDate *testDate = [NSDate distantPast];
    question.date = testDate;
    XCTAssertEqualObjects(question.date, testDate, @"question needs to provide its date");
}

- (void)testQuestionsKeepScore {
    XCTAssertEqual(question.score, 42, @"questions need a numeric score");
}

- (void)testQuestionHasATitle {
    XCTAssertEqualObjects(question.title, @"do iphones also dream of electric sheep?", @"question should know its title");
    
}


@end
