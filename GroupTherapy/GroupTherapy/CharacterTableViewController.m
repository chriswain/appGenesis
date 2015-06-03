//
//  CharacterTableViewController.m
//  GroupTherapy
//
//  Created by Christopher Wainwright Aaron on 6/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

#import "CharacterTableViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "CharacterTableViewCell.h"

#define API_BASE @"http://gateway.marvel.com/v1/public/"

#define PUBLIC_KEY @"fdc4736ce93c8888fbe1cc268777919b"

#define PRIVATE_KEY @"b6ff60fc7fadd3107d1d6d8d52a9c750437f0a39"

@interface CharacterTableViewController () <UIScrollViewDelegate>

@end


@implementation CharacterTableViewController

{
    NSArray * characters;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self characterList];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0) {
        
    }
    
    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight) {
        
    }
    
    [self characterList];
    
    
}

-(void)characterList {
    
    int timeStamp = [NSDate date].timeIntervalSince1970;
    
    NSString * hash = [self MD5String:[NSString stringWithFormat:@"%d%@%@",timeStamp, PRIVATE_KEY, PUBLIC_KEY]];
    
    // base url, endpoint, parameters
    // gateway.marvel.com/v1/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150
    
    NSString * endpoint = [NSString stringWithFormat:@"%@characters?limit=50&offset=%d&ts=%d&apikey=%@&hash=%@", API_BASE, characters.count, timeStamp, PUBLIC_KEY, hash];
    
    NSLog(@"%@",endpoint);
    
    NSURL * url = [NSURL URLWithString:endpoint];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:([NSOperationQueue mainQueue] ) completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"%@",JSON);
        
        characters = JSON[@"data"][@"results"];
        characters = [characters arrayByAddingObjectsFromArray:characters];
        
        NSLog(@"%@",characters);
        
        [self.tableView reloadData];
        
    }];
    
    
}


- (NSString *)MD5String:(NSString *)input {
    // Create pointer to the string as UTF8
    const char *ptr = [input UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return characters.count;
}


- (CharacterTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"characterCircle" forIndexPath:indexPath];
    
    cell.textLabel.text = characters[indexPath.row][@"name"];
    
    NSDictionary * character = characters[indexPath.row];
    
    if (character[@"thumbnail"] != nil && character[@"thumbnail"] != [NSNull null]) {
        
        NSString * imagePath = character[@"thumbnail"][@"path"];
        NSString * imageExtension = character[@"thumbnail"][@"extension"];
        
        NSString * fullImageString = [NSString stringWithFormat:@"%@/portrait_small.%@", imagePath, imageExtension];
        NSLog(@"%@",fullImageString);
        
        NSURL * imageURL = [NSURL URLWithString: fullImageString];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
             NSData * imageData = [NSData dataWithContentsOfURL: imageURL];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage * characterImage = [UIImage imageWithData: imageData];
                
                cell.imageView.image = characterImage;
                
            });
            
        });
        
        
    }
    
    // Configure the cell...
    

    
    return cell;
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
