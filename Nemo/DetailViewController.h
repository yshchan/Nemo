//
//  NewObjectViewController.h
//  Nemo
//
//  Created by Yashwant Chauhan on 10/21/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UlyssesTextView.h"

#import "Note.h"

@class Note;

@interface DetailViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) NSManagedObject *itemToEdit;

@property (strong, nonatomic) IBOutlet UlyssesTextView *textView;

@end
