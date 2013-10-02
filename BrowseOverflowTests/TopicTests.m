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

@end
