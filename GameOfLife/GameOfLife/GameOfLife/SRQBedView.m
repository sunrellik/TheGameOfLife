//
//  SRQBedView.m
//  GameOfLife
//
//  Created by 孙荣乾 on 2017/6/24.
//  Copyright © 2017年 sunrongqian. All rights reserved.
//

#import "SRQBedView.h"


@interface Cell  : NSObject

@property (nonatomic,assign) int  x;
@property (nonatomic,assign) int  y;
@property (nonatomic,assign) BOOL alive_new;//细胞新一代的生存状态
@property (nonatomic,assign) BOOL alive_old;//细胞老一代的生存状态


@end

@implementation Cell


@end

@interface SRQBedView ()
{
    NSMutableArray * cells;
}

@end

@implementation SRQBedView


/**
  初始化视图时对应每一个格子生成对应的细胞对象 储存在二维数组中

 @param frame  视图的frame
 @return  返回对应的视图
 */
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0];
        
        cells=[NSMutableArray array];
        for (int i=1; i<=SIZE; i++) {
            NSMutableArray * row=[NSMutableArray array];
            for (int j=1; j<=SIZE; j++) {
                Cell * cell=[[Cell alloc]init];
                cell.x=i;
                cell.y=j;
                [row addObject:cell];
            }
            [cells addObject:row];
        }
    }
    return self;
}


/**
 根据细胞新一代的生存死亡来绘制视图

 @param rect rect
 */
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    
    for (int i=0; i<SIZE; i++) {
        for (int j=0; j<SIZE; j++) {
            Cell * cell=cells[i][j];
            if (cell.alive_new) {
                CGContextFillRect(context, CGRectMake((cell.x-1)*BEDWIDTH, (cell.y-1)*BEDHEIGHT, BEDWIDTH, BEDHEIGHT));
            }
        }
    }
    
    CGContextStrokePath(context);
}

/**
 随机决定初代细胞生存状态 进行初代繁殖 此时细胞的新老一代生存状态是相同的
 */
-(void)start{
    
    for (int i=0; i<SIZE; i++) {
        for (int j=0; j<SIZE; j++) {
            Cell * cell=cells[i][j];
            cell.alive_new=NO;
            cell.alive_old=NO;
            if (arc4random()%RANDUM) {
                cell.alive_new=NO;
                cell.alive_old=NO;
            }else{
                cell.alive_new=YES;
                cell.alive_old=YES;
            }
        }
    }
    [self setNeedsDisplay];
}

/**
 繁殖参数相应的代数

 @param steps 步数
 */
-(void)nextStep:(int)steps{
   
    for (int s=0; s<steps; s++) {
        for (int i=0; i<SIZE; i++) {
            for (int j=0; j<SIZE; j++) {
                Cell * cell=cells[i][j];
                int count=[self CellsAround:cell];
                if (cell.alive_old) {//上一代存活时 周围有2-3个细胞时新一代继续存活 反之死亡
                    if (count<2||count>3) {
                        cell.alive_new=NO;
                    }else{
                        cell.alive_new=YES;
                    }
                }else{//上一代死亡时 周围有3个细胞时细胞复活
                    if (count==3) {
                        cell.alive_new=YES;
                    }
                }
                cell.alive_old=cell.alive_new;//细胞繁殖结束 更新新老生存状态
            }
        }
    }
    
    [self setNeedsDisplay];
}

/**
 以细胞为中心的九宫格内共有多少个存活的细胞 遍历9宫格时自身存活状态须考虑

 @param cell 目标细胞
 @return 周围细胞存活个数
 */
-(int)CellsAround:(Cell*)cell{
    int count = 0, row, column;
    
    for(row = cell.x-2; row <= cell.x; row++)

        for(column = cell.y-2; column <= cell.y; column++) {
            if(row < 0 || row >= SIZE ||column < 0 || column >= SIZE){
                //上下限不能超过边界
                continue;
            }

            if([cells[row][column] alive_old]){
                count++;
            }
            
        }
    
    if(cell.alive_old){
        count--;
    }
    return count;
}


@end
