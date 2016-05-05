//
//  Obstacle.m
//  RhymingWordsTargetShooting
//
//  Created by Dandan Song on 4/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//


#import "Obstacle.h"


@implementation Obstacle

- (void)didLoadFromCCB {
    _balloonHit=0;
    
    _words=@"";
}
- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CCLOG(@"Received a touch...");
    self.balloonHit=1;
    
    [self.myscene balloontouch:self];
    
}

@end
