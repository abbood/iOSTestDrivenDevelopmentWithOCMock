//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject

- (NSArray *)questionsFromJSON: (NSString *)objectNotation
                         error: (NSError **)error;

@end
