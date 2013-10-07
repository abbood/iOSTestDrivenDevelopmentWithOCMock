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

@interface OCMockQuestionCreationTests : XCTestCase

@end

@implementation OCMockQuestionCreationTests

{
@private
    StackOverflowManager *mgr;
    id delegate;
    NSError *underlyingError;
}

- (void)setUp {
    mgr = [[StackOverflowManager alloc] init];
    delegate = [OCMockObject mockForProtocol:@protocol(StackOverflowManagerDelegate)];
    
    // note: unlike the books code.. we DON'T set mgr.delegate = delegate here
    // b/c for some reason that runs some expectation code on it.. and causes some tests
    // to fail incorrectly..
    // for example if you try setting it here.. you'll see testQuestionJSONIsPassedToQuestionBuilder
    // failing with error message:
    // [OCMockQuestionCreationTests testQuestionJSONIsPassedToQuestionBuilder] failed
    // OCMockObject[StackOverflowManagerDelegate]: unexpected method invoked: fetchingQuestionsFailedWiotheRror: Error Domain=StackOverflowManagerSearchFailedError Code=0"The Operation couldn't be completed. (StacOverflowManagerSearchFailedError error 0.)"
    //mgr.delegate = delegate;
    
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
    mgr.delegate = delegate;
    [[delegate expect] fetchingQuestionsFailedWithError:[OCMArg isNotEqual:underlyingError]];
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    [delegate verify];
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    mgr.delegate = delegate;
    [[delegate expect] fetchingQuestionsFailedWithError:[OCMArg checkWithBlock:^BOOL(id param) {
        return ([[param userInfo] objectForKey:NSUnderlyingErrorKey] == underlyingError);
    }]];
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    [delegate verify];
}

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    id builderMock = [OCMockObject mockForClass:[QuestionBuilder class]];
    mgr.questionBuilder = builderMock;
    [[builderMock expect] questionsFromJSON:@"Fake JSON" error:(NSError * __autoreleasing *)[OCMArg anyPointer]];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    [builderMock verify];
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails {
    mgr.delegate = delegate;
    id builderMock = [OCMockObject mockForClass:[QuestionBuilder class]];
    mgr.questionBuilder = builderMock;
    
    [[[builderMock stub] andReturn:nil] questionsFromJSON:@"Fake JSON" error:[OCMArg setTo:underlyingError]];
    [[delegate expect] fetchingQuestionsFailedWithError:[OCMArg checkWithBlock:^BOOL(id param) {
        
        return ([[param userInfo] objectForKey:NSUnderlyingErrorKey] == underlyingError);
        
    }]];
    
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    [delegate verify];
    
    mgr.questionBuilder = nil;
}

@end
