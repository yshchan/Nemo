//
//  DistractionFreeTextView.m
//  NotesApp
//
//  Created by Yashwant Chauhan on 9/25/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import "UlyssesTextView.h"

@interface UlyssesTextView ()

@end

@implementation UlyssesTextView

#pragma mark - Attribute String

- (void)formatTextInTextView:(UITextView *)textView
{
    textView.scrollEnabled = NO;
    NSRange selectedRange = textView.selectedRange;
    NSString *text = textView.text;
    
    // This will give me an attributedString with the base text-style
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attributedString addAttribute:NSFontAttributeName value:[textView font] range:NSMakeRange(0, text.length)];
    
    UIColor *highlightColor = [UIColor colorWithHexString:@"D9E8C2"];
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)|" options:0 error:&error];
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, text.length)];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match rangeAtIndex:0];
        [attributedString addAttribute:NSBackgroundColorAttributeName
                                 value:highlightColor
                                 range:matchRange];
    }
    
    NSRange dateRange = [text rangeOfDateTimeFromString];
    if (dateRange.location != NSNotFound) {
        [attributedString addAttributes:@{NSBackgroundColorAttributeName: highlightColor} range:dateRange];
    }
    
    textView.attributedText = attributedString;
    textView.selectedRange = selectedRange;
    textView.scrollEnabled = YES;
}

#pragma mark -

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    [self formatTextInTextView:self];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) ) {}
    return self;
}

- (void)textChanged:(NSNotification *)notification {
    [self formatTextInTextView:self];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // configure couple of things
    self.clipsToBounds = YES;
    self.scrollEnabled = YES;
    self.userInteractionEnabled = YES;
    self.textContainerInset = UIEdgeInsetsMake(28, 15, 10, 10);
}

@end
