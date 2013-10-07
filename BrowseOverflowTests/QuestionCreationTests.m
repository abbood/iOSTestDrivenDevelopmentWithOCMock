//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "StackOverflowManager.h"
#import "Topic.h"
#import "StackOverflowCommunicator.h"
#import "MockStackOverflowManagerDelegate.h"
#import "FakeQuestionBuilder.h"

@interface QuestionCreationTests : XCTestCase

@end

@implementation QuestionCreationTests

{
    @private
    StackOverflowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    id delegateMock;
    NSError *underlyingError;
}

- (void)setUp {
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain: @"Test domain"
                                          code: 0 userInfo: nil];
}

- (void)tearDown {
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
}

- (void)testNonConformingObjectCannotBeDelegate {
    XCTAssertThrows(mgr.delegate = (id<StackOverflowManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate and doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate {
    XCTAssertNoThrow(mgr.delegate = delegate, @"object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsADelegate {
    XCTAssertNoThrow(mgr.delegate = nil,
                    @"It should be acceptable to use nil as an object’s delegate");
}

- (void)testAskingForQuestionsMeansRequestingData {
    id communicator = [OCMockObject mockForClass:[StackOverflowCommunicator class]];
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName: @"iPhone"
                                           tag: @"iphone"];
    [[(id)mgr.communicator expect] searchForQuestionsWithTag:topic.tag];
    [mgr fetchQuestionsOnTopic: topic];
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator {
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError],
                  @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    XCTAssertEqual([[[delegate fetchError] userInfo]
                          objectForKey: NSUnderlyingErrorKey], underlyingError,
                         @"The underlying error should be available to client code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON",
                         @"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails {
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo]
                    objectForKey: NSUnderlyingErrorKey],
                   @"The delegate should have found out about the error");
    mgr.questionBuilder = nil;
}


@end
