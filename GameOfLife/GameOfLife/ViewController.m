//
//  ViewController.m
//  GameOfLife
//
//  Created by 孙荣乾 on 2017/6/24.
//  Copyright © 2017年 sunrongqian. All rights reserved.
//

#import "ViewController.h"
#import "SRQHouseView.h"
#import "SRQBedView.h"

@interface ViewController ()
{
    SRQBedView * bed;
}
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self prepareForGame];
}

-(void)prepareForGame{
    
    self.view.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    
    SRQHouseView * house=[[SRQHouseView alloc]initWithFrame:CGRectMake(0, 0, GAMEWIDTH, GAMEHEIGHT)];
    house.center=self.view.center;
    
    [self.view addSubview:house];
    
    bed=[[SRQBedView alloc]initWithFrame:CGRectMake(0, 0, GAMEWIDTH, GAMEHEIGHT)];
    bed.center=self.view.center;
    
    [self.view addSubview:bed];
    
}

- (IBAction)start:(id)sender {
    [bed start];
}
- (IBAction)nextStep:(id)sender {
    [bed nextStep:1];
}
- (IBAction)randomSteps:(id)sender {
    [bed nextStep:arc4random()%5];
}
- (IBAction)reset:(id)sender {
    [bed start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
