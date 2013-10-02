//
//  Person.h
//  BrowseOverflow
//
//  Created by Abdullah Bakhach on 10/2/13.
//  Copyright (c) 2013 Scryptech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property NSString *name;
@property NSURL *avatarURL;

- (id)initWithName:(NSString *)newName avatarLocation:(NSString *)newLocation;

@end
