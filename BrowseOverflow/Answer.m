//
//  Answer.m
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import "Answer.h"

@implementation Answer


- (NSComparisonResult)compare:(Answer *)otherAnswer {
    if (_accepted && !(otherAnswer.accepted)) {
        return NSOrderedAscending;
    } else if (!_accepted && otherAnswer.accepted){
        return NSOrderedDescending;
    }
    if (_score > otherAnswer.score) {
        return NSOrderedAscending;
    } else if (_score < otherAnswer.score) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

@end
