//
//  ViewController.m
//  RandomLearning
//
//  Created by Christopher Wainwright Aaron on 6/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self circleMake];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)circleMake {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect circleViewRect = CGRectMake(50, 100, 100, 100);
    
    UIView * circle = [[UIView alloc] initWithFrame:circleViewRect];
    
    circle.backgroundColor = [UIColor blueColor];
    
    circle.layer.cornerRadius = 50;
    
    [self.view setNeedsDisplay];

}



@end
