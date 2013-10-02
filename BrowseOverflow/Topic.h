//
//  Topic.h
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *tag;

- (id)initWithName:(NSString *)newName tag:(NSString *)newTag;

@end
