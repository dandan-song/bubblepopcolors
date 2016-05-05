//
//  Target.m
//  shootingGame
//
//  Created by Dandan Song on 3/27/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Target.h"


@implementation Target

- (void)didLoadFromCCB {
    [super didLoadFromCCB];
     self.physicsBody.collisionType = @"Target";
    //self.physicsBody.sensor = TRUE;
    
 }
- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = TRUE;
}

@end
