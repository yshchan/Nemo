//
//  MasterViewController.h
//  Nemo
//
//  Created by Yashwant Chauhan on 10/29/13.
//  Copyright (c) 2013 NorthStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
