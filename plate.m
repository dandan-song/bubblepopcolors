//
//  plate1.m
//  shootingGame
//
//  Created by Dandan Song on 3/24/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "plate.h"


@implementation plate
- (void)didLoadFromCCB {
    [super didLoadFromCCB];
     self.physicsBody.collisionType = @"plate";
}
- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = TRUE;
}


@end
