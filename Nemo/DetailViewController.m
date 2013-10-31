//
//  NewObjectViewController.m
//  Nemo
//
//  Created by Yashwant Chauhan on 10/21/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    UIToolbar *_keyboardToolbar;
}
-(void)configureView;
@end

@implementation DetailViewController

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupNavigationBar {
//    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction target:self action:nil];
//    
//    NSArray *buttonSet = [[NSArray alloc]initWithObjects:shareItem, nil];
//    self.navigationItem.rightBarButtonItems = buttonSet;
}

- (void)configureView
{
    if (_itemToEdit) {}
    
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {

        if ([_itemToEdit isKindOfClass:[Note class]]) {
            Note *note = (Note*)_itemToEdit;
            
            note.title = [[_textView.text lines] objectAtIndex:0];
            note.content = _textView.text;
        }

        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        [context MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
            NSLog(@"'%@' saved...",[_itemToEdit description]);
        }];
    }
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupTextView];
    [self setupNavigationBar];
    
    self.title = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

#pragma mark - Text View

-(void)setupTextView {
    
    NSString *text = @"";
    
    if ([_itemToEdit isKindOfClass:[Note class]]) {
        Note *note = (Note*)_itemToEdit;
        text = note.content;
    }

    _textView.text = text;
    
    _textView.font = [UIFont fontWithName:@"Verdana" size:16];
    _textView.delegate = self;
    
    if(_keyboardToolbar == nil) {
        _keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 44)];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancelTextView:)];
        
        [_keyboardToolbar setItems:[[NSArray alloc] initWithObjects:space, cancel, nil] animated:YES];
        
        _textView.inputAccessoryView = _keyboardToolbar;
        
        UIColor *tintColor = nil;
        UIColor *backgroundColor = nil;
        UIColor *baseColor = [_textView backgroundColor];
        
        tintColor = baseColor.inverse;
        backgroundColor = baseColor;
        
        _keyboardToolbar.tintColor = tintColor;
        _keyboardToolbar.barTintColor = backgroundColor;
    }
}

-(void)cancelTextView:(id)sender {
    [_textView resignFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView {}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:0.0];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    CGRect endRect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect newRect = _textView.frame;
    newRect.size.height -= endRect.size.height;
    _textView.frame = newRect;
    
    // CGRect keyboardFrame = CGRectMake(0, 0, 320, 216);
    _textView.frame = CGRectMake(_textView.frame.origin.x, _textView.frame.origin.y, _textView.frame.size.width, _textView.frame.size.height + 51);
    [UIView commitAnimations];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.navigationController.navigationBar setAlpha:1.0];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView commitAnimations];
}

#pragma mark - Memory

- (void)setItemToEdit:(NSManagedObject *)newItemToEdit
{
    if (_itemToEdit != newItemToEdit) {
        _itemToEdit = newItemToEdit;
        
        // Update the view.
        [self configureView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
