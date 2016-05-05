//
//  airPlane.m
//  shootingGame
//
//  Created by Dandan Song on 3/26/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "airPlane.h"


@implementation airPlane

- (void)didLoadFromCCB {
    [super didLoadFromCCB];
     self.physicsBody.collisionType = @"airPlane";
    //self.physicsBody.sensor = TRUE;
    
 }
- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = TRUE;
}


@end
