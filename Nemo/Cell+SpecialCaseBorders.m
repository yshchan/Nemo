//
//  MainCell+SpecialCaseBorders.m
//  Nemo
//
//  Created by Yashwant Chauhan on 10/24/13.
//  Copyright (c) 2013 Yashwant Chauhan. All rights reserved.
//

#import "Cell+SpecialCaseBorders.h"

@implementation Cell (SpecialCaseBorders)

// FIXME: Resolve why you can't use these borders? Both (dottedSeparator and lineSeparator)

-(void)dottedSeparator {
    UIImageView *separatorLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, 320, 1)];
    
    UIImage *image = [UIImage imageNamed:@"dotted-line-brown.png"]; // remove "brown" as suffix, if background is white.
    CGSize imageViewSize = separatorLineView.bounds.size;
    
    UIGraphicsBeginImageContext(imageViewSize);
    
    CGRect imageRect;
    imageRect.origin = CGPointMake(0.0, 0.0);
    imageRect.size = CGSizeMake(image.size.width, image.size.height);
    
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    CGContextDrawTiledImage(imageContext, imageRect, image.CGImage);
    
    UIImage *finishedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [separatorLineView setImage:finishedImage];
    
    [self.contentView addSubview:separatorLineView];
}

-(void)lineSeparator {
    struct CGColor *borderColor = self.borderColor.CGColor;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.frame.size.height - 1, 320, 1);
    bottomBorder.backgroundColor = borderColor;
    
    [self.layer addSublayer:bottomBorder];
}

@end
