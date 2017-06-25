//
//  SRQBedView.h
//  GameOfLife
//
//  Created by 孙荣乾 on 2017/6/24.
//  Copyright © 2017年 sunrongqian. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 细胞繁殖器皿
 */
@interface SRQBedView : UIView
-(void)start;

-(void)nextStep:(int)steps;

@end
