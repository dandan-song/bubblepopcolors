//
//  Obstacle.h
//  RhymingWordsTargetShooting
//
//  Created by Dandan Song on 4/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef RhymingWordsTargetShooting_Obstacle_h
#define RhymingWordsTargetShooting_Obstacle_h
//
//  Target.h
//  shootingGame
//
//  Created by Dandan Song on 3/27/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneTouchDelegate.h"

@interface Obstacle : CCNode {

}
- (void)didLoadFromCCB;

@property int balloonHit;
@property NSString* words;
@property NSNumber* tag;
@property CCNode <SceneTouchDelegate>  *myscene;

//more variables depend on type of obstacle
@end


#endif
