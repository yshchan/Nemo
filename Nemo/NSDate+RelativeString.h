//
//  NSDate+RelativeString.h
//  OneWithNoTitle
//
//  Created by Yashwant Chauhan on 31/07/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RelativeString)

-(NSString*)relativeWeekday;
-(NSString*)relativeShortDate;
-(NSString*)relativeDate;
-(NSString*)shortenedWeekday;
-(NSString*)getMonth;

@end
