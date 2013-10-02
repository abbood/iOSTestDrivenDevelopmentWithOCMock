//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PersonTests : XCTestCase

@end

#import "Person.h"
@implementation PersonTests {
    Person *person;
}

- (void)setUp
{
    person = [[Person alloc] initWithName:@"Graham lee" avatarLocation:@"http://example.com/avatar.png"];
}

- (void)tearDown
{
    person = nil;
}

- (void)testTahtPersonHasTheRightName {
    XCTAssertEqualObjects(person.name, @"Graham lee", @"expecting a person to provide its name");
}

- (void)testThatPersonHasAnAvatarURL {
    NSURL *url = person.avatarURL;
    XCTAssertEqual([url absoluteString], @"http://example.com/avatar.png", @"the person's avatar should be reprsented by a url");
}


@end
