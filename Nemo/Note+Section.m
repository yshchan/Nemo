//
//  Note+Section.m
//  Nemo
//
//  Created by Yashwant Chauhan on 10/22/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import "Note+Section.h"

@implementation Note (Section)

-(NSString*)monthGroup; {
    NSString *name = @"Unknown Month";
    NSString *month = [self.dateCreated getMonth];
    if (![month isEqualToString:@""]) {
        name = month;
    }
    return name;
}

@end
