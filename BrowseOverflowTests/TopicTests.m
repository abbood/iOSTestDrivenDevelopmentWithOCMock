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
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatTopicsExist {
    Topic *newTopic = [[Topic alloc] init];
    XCTAssertNotNil(newTopic, @"should be able to create topic instance");
}

- (void)testThatTopicCanBeNamed {
    Topic *namedTopic = [[Topic alloc] initWithName: @"iphone" tag:@"iphone"];
    XCTAssertEqualObjects(namedTopic.name, @"iphone", @" the topic should have the name i give it");
}

- (void)testThatTopicHasATag {
    Topic *taggedTopic = [[Topic alloc] initWithName: @"iphone" tag:@"iphone"];
    XCTAssertEqualObjects(taggedTopic.tag, @"iphone", @"topics need to have tags");
    
}

@end
