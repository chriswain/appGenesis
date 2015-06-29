//
//  ViewController.h
//  TakeASelfie
//
//  Created by Christopher Wainwright Aaron on 6/3/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) UIImage * original;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *unfilteredImageView;

@end

