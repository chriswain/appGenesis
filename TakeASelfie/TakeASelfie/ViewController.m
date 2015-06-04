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


@end

@implementation ViewController

{
    NSArray * filters;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.original;
    
    filters = [CIFilter filterNamesInCategory:kCICategoryColorEffect];
    
    self.filterCollectionView.dataSource = self;
    self.filterCollectionView.delegate = self;
    
}

-(UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0, 200,200)];
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
    
    cell.imageViewPic.image = [self filterImage: [self imageWithImage:self.original scaledToSize:(CGSizeMake(200, 200))] withName:filterName];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * filterName = filters[indexPath.item];
    
    UIImage * resizedImage = [self imageWithImage: self.imageView.image scaledToSize:(CGSizeMake(60, 50))];
    
    UIImage * filterImage = [self filterImage:resizedImage withName:filterName];
    
    self.imageView.image = filterImage;
    
    
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



@end







