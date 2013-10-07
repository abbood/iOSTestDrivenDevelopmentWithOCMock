//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"

@implementation MockStackOverflowManagerDelegate

@synthesize fetchError;

- (void)fetchingQuestionsFailedWithError: (NSError *)error {
    self.fetchError = error;
}

@end
