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
#import "Answer.h"
@implementation QuestionTests {
    Question *question;
    Answer *lowScore;
    Answer *highScore;
}

- (void)setUp {
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
    
    Answer *accepted = [[Answer alloc] init];
    accepted.score = 1;
    accepted.accepted = YES;
    [question addAnswer: accepted];
    
    lowScore = [[Answer alloc] init];
    lowScore.score = -4;
    [question addAnswer: lowScore];
    
    highScore = [[Answer alloc] init];
    highScore.score = 4;
    [question addAnswer: highScore];
}

- (void)tearDown {
    question = nil;
    lowScore = nil;
    highScore = nil;
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
    XCTAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?", @"question should know its title");
    
}

- (void)testQuestionCanHaveAnswersAdded {
    Answer *myAnswer = [[Answer alloc] init];
    XCTAssertNoThrow([question addAnswer: myAnswer],
                    @"Must be able to add answers");
}
- (void)testAcceptedAnswerIsFirst {
    XCTAssertTrue([[question.answers objectAtIndex: 0] isAccepted],
                 @"Accepted answer comes first");
}
- (void)testHighScoreAnswerBeforeLow {
    NSArray *answers = question.answers;
    NSInteger highIndex = [answers indexOfObject: highScore];
    NSInteger lowIndex = [answers indexOfObject: lowScore];
    XCTAssertTrue(highIndex < lowIndex,
                 @"High-scoring answer comes first");
}


@end
