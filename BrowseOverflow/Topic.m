//
//  Topic.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "Topic.h"

@implementation Topic

@synthesize name;
@synthesize tag;

- (id)initWithName:(NSString *)newName tag:(NSString *)newTag {
    if ((self = [super init])) {
        name = [newName copy];
        tag = [newTag copy];
    }
    
    return self;
}



@end
