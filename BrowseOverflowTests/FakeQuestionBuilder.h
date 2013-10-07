//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionBuilder.h"

@class Question;

@interface FakeQuestionBuilder : QuestionBuilder
@property (copy) NSString *JSON;
@property (copy) NSArray *arrayToReturn;
@property (copy) NSError *errorToSet;
@end
