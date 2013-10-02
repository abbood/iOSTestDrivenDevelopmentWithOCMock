//
//  Person.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name;
@synthesize avatarURL;

- (id)initWithName:(NSString *)newName avatarLocation:(NSString *)newLocation {
    if ((self = [super init])) {
        name = [newName copy];
        avatarURL = [[NSURL alloc] initWithString:newLocation];
    }
    
    return self;
}

@end
