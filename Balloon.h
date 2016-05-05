//
//  Balloon.h
//  shootingGame
//
//  Created by Dandan Song on 2/24/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Obstacle.h"

@interface Balloon : Obstacle
@property CCNode *balloon;
@property CCLabelTTF *word;
@property int balloonHit;
@property CCSprite *square;
 
@property CCSprite *rectangle;
@property CCSprite *triangle;
@property CCSprite *oval;
@property CCSprite *circle;
@property CCSprite *diamond;

@end
