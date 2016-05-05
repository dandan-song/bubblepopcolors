//
//  CCDragSprite.m
//  shootingGame
//
//  Created by Dandan Song on 2/22/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "CCDragSprite.h"


@implementation CCDragSprite

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"balloon";
    self.physicsBody.sensor = TRUE;
}

- (void)onEnter {
   [super onEnter];
  self.userInteractionEnabled = TRUE;
}
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
     CCLOG(@"Received a touch...");
}
- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self.parent];
    self.position = touchLocation;
}

@end
