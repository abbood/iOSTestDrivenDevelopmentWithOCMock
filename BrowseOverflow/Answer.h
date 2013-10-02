//
//  Answer.h
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Answer : NSObject


@property NSString *text;
@property Person *person;
@property NSInteger score;
@property (getter=isAccepted) BOOL accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;

@end
