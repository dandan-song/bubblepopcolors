//
//  SceneTouchDelegate.h
//  RhymingWordsTargetShooting
//
//  Created by Dandan Song on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef RhymingWordsTargetShooting_SceneTouchDelegate_h
#define RhymingWordsTargetShooting_SceneTouchDelegate_h
@class Obstacle;

@protocol SceneTouchDelegate
-(void)balloontouch:(Obstacle *)b;
@end
#endif
