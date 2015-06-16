//
//  ViewController.m
//  TakeASelfie
//
//  Created by Christopher Wainwright Aaron on 6/3/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

#import "ViewController.h"
#import "FilterCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;

@property (nonatomic) NSString * currentFilter;
@property (nonatomic) CGFloat currentIntensity;


@end

@implementation ViewController

{
    NSArray * filters;
    UIImage * resizedImage;
}

-(void)setCurrentIntensity:(CGFloat)currentIntensity {
    
    self.imageView.alpha = currentIntensity;
    
    _currentIntensity = currentIntensity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.original;
    self.unfilteredImageView.image = self.original;
    
    self.currentIntensity = 1.0;
    
    resizedImage = [self imageWithImage:self.original scaledToSize:CGSizeMake(200, 200)];
    
    filters = [CIFilter filterNamesInCategory:kCICategoryColorEffect];
    
    self.filterCollectionView.dataSource = self;
    self.filterCollectionView.delegate = self;
    
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    CGRect scaleImageRect = CGRectMake(0, 0, newSize.width, newSize.height);
    
    if (newSize.height / newSize.width != image.size.height / image.size.width) {
        
        if (image.size.height > image.size.width) {
            //portrait
            CGFloat ratio = newSize.width / image.size.width;
            
            CGFloat newHeight = ratio * image.size.height;
            
            CGFloat newY = (newSize.height - newHeight) / 2;
            
            scaleImageRect = CGRectMake(0, newY, newSize.width, newHeight);
            
        } else {
           
            //landscape
            CGFloat ratio = newSize.height / image.size.height;
            
            CGFloat newWidth = ratio * image.size.width;
            
            CGFloat newX = (newSize.width - newWidth) / 2;
            
            scaleImageRect = CGRectMake(newX, 0, newWidth, newSize.height);
        }
        
    }
    
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:scaleImageRect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return filters.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FilterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"filterCell" forIndexPath:indexPath];
    
    
    NSString * filterName = filters[indexPath.item];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        
        UIImage * filterImage = [self filterImage:resizedImage withName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageViewPic.image = filterImage;
       
        });
        
        
    });
    
    
    
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * filterName = filters[indexPath.item];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * resetImage = [self imageWithImage:self.original scaledToSize:self.original.size];
        
        UIImage * filterImage = [self filterImage:resetImage withName:filterName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageView.image = filterImage;
            
        });
        
        
    });

    
    
    
}

- (UIImage *)filterImage:(UIImage *)originalImage withName:(NSString *)filterName {
    
    CIContext * context = [CIContext contextWithOptions:nil];
    
    CIImage * image = [CIImage imageWithCGImage:originalImage.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:filterName];
    
    [filter setValue:image forKey:kCIInputImageKey];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGRect extent = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
    
    return [UIImage imageWithCGImage:cgImage];

}

- (IBAction)goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)filterIntensityChanged:(UISlider *)sender {
    
    self.currentIntensity = sender.value;
}

@end







