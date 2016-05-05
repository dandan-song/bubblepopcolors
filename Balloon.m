//
//  Balloon.m
//  shootingGame
//
//  Created by Dandan Song on 2/24/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Balloon.h"

@implementation Balloon


- (void)didLoadFromCCB {
    [super didLoadFromCCB];
   self.balloonHit=0;
     self.physicsBody.collisionType = @"balloon";
//self.physicsBody.sensor = TRUE;
    
 }

- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = TRUE;
}
#if 0
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CCLOG(@"Received a touch...");
    self.balloonHit=1;

    
    
 }

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self.parent];
//self.position = touchLocation;
}
- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
   // self.balloonHit=0;
//self.visible=false;
//   CCLOG(@"touch balloon is over");
}
#endif
@end
