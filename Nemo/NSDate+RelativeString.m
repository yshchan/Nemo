//
//  NSDate+RelativeString.m
//  OneWithNoTitle
//
//  Created by Yashwant Chauhan on 31/07/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import "NSDate+RelativeString.h"
#import "NSDate+DateRange.h"
#import "NSString+Extended.h"

@implementation NSDate (RelativeString)

-(NSString*)relativeWeekday {
    NSDate *today = [NSDate date];
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    currentCalendar.firstWeekday = 1;
    NSDateComponents *componentsForCurrent = [currentCalendar components:NSWeekOfYearCalendarUnit fromDate:today];
    NSDateComponents *componentsForDate = [currentCalendar components:NSWeekOfYearCalendarUnit fromDate:self];
    NSUInteger currentWeek = [componentsForCurrent weekOfYear];
    NSUInteger dateWeek = [componentsForDate weekOfYear];
    
    NSUInteger weekdayInt = [[currentCalendar components:NSWeekdayCalendarUnit fromDate:self] weekday];
    NSString *weekDay = nil;
    
    if (currentWeek == dateWeek) {
        switch (weekdayInt) {
            case 1:
                weekDay = @"Sunday";
                break;
            case 2:
                weekDay = @"Monday";
                break;
            case 3:
                weekDay = @"Tuesday";
                break;
            case 4:
                weekDay = @"Wednesday";
                break;
            case 5:
                weekDay = @"Thursday";
                break;
            case 6:
                weekDay = @"Friday";
                break;
            case 7:
                weekDay = @"Saturday";
                break;
            default:
                break;
        }
    }
    if (!weekDay) { NSLog(@"Weekday is nil."); }
    return weekDay;
}

-(NSString*)relativeShortDate; {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd"];
    NSString *relativeString = [[dateFormatter stringFromDate:self] removeSubstring:[NSString stringWithFormat:@", %ld",(long)[self year]]];
    
    NSCharacterSet *notAllowedChars = [NSCharacterSet characterSetWithCharactersInString:@".!@#$%^&*()_+|"]; 
    NSString *filteredString = relativeString;
    if ([relativeString rangeOfCharacterFromSet:notAllowedChars].location != NSNotFound) {
        filteredString = [[relativeString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    }
    return [filteredString capitalizedString];
}

-(NSString*)shortenedWeekday; {
    NSString *weekdayString = [self relativeWeekday];    
    NSString *newString = [weekdayString substringWithRange:NSMakeRange(0, weekdayString.length-3)];
    if (!newString) { NSLog(@"Shortened weekday is nil."); }
    return newString;
}

-(NSString*)relativeDate; {
    if ([(NSDate*)self isToday]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm a"];
        return [formatter stringFromDate:(NSDate*)self];
    } else if ([(NSDate*)self isTomorrow]) {
        return @"Tommorow";
    } else if ([(NSDate*)self isThisWeek]) {
        return [(NSDate*)self relativeWeekday];
    } else {
        return [(NSDate*)self relativeShortDate];
    }
}

-(NSString*)getMonth; {
    NSDate *date = (NSDate*)self;
    int monthNumber = [date month];
    NSString * dateString = [NSString stringWithFormat: @"%d", monthNumber];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSDate* myDate = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [formatter stringFromDate:myDate];
    
    return stringFromDate;
}

@end
