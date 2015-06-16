//
//  GameScene.h
//  PixelAdventure
//

//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

-(void)movePixelInDirection:(CGVector)direction;
-(void)changePixelDirection:(CGFloat)direction;


-(void)normalAttack;
-(void)specialAttack;

@end
