//
//  NoteCell.m
//  Nemo
//
//  Created by Yashwant Chauhan on 10/21/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import "NoteCell.h"

@interface NoteCell () {}
@end

@implementation NoteCell

@synthesize textLabel=_textLabel;

-(UILabel *)textLabel {
    return _textLabel;
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.textLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
