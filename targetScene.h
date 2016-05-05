//
//  targetScene.h
//  shootingGame
//
//  Created by Dandan Song on 3/27/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneTouchDelegate.h"

@interface targetScene : CCNode <CCPhysicsCollisionDelegate, SceneTouchDelegate> {
    
}
@property int question;
@property int score;
@end
