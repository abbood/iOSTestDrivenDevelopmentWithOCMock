//
//  STackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/6/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject

- (void)searchForQuestionsWithTag: (NSString *)tag;
- (BOOL)wasAskedtoFetchQuestions;

@end
