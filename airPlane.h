//
//  airPlane.h
//  shootingGame
//
//  Created by Dandan Song on 3/26/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Obstacle.h"

@interface airPlane : Obstacle {
    
}

@property CCNode *balloon;
@property CCLabelTTF *word;
@property int balloonHit;
@property CCSprite *square;

@property CCSprite *rectangle;
@property CCSprite *triangle;
@property CCSprite *oval;
@property CCSprite *circle;
@property CCSprite *diamond;
#if 0
@property int balloonHit;
@property NSString* words;
@property NSNumber* tag;
#endif
@end
