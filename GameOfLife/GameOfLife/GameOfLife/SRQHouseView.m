//
//  SRQHouseView.m
//  GameOfLife
//
//  Created by 孙荣乾 on 2017/6/24.
//  Copyright © 2017年 sunrongqian. All rights reserved.
//

#import "SRQHouseView.h"


@interface SRQHouseView ()

@end

@implementation SRQHouseView



- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, .5);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    for (int i=0; i<=SIZE; i++) {
        CGContextMoveToPoint(context, BEDWIDTH*i, 0);
        CGContextAddLineToPoint(context, BEDWIDTH*i, GAMEHEIGHT);
        
        CGContextMoveToPoint(context, 0, BEDHEIGHT*i);
        CGContextAddLineToPoint(context, GAMEWIDTH, BEDHEIGHT*i);
       
    }
    
    CGContextStrokePath(context);
}


@end
