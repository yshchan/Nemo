//
//  Note.h
//  Nemo
//
//  Created by Yashwant Chauhan on 10/29/13.
//  Copyright (c) 2013 NorthStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * dateCreated;

@end
