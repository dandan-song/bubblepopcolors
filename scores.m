//
//  scores.m
//  shootingGame
//
//  Created by Dandan Song on 3/30/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "scores.h"
#import "GCHelper.h"
#import "GameState.h"

@implementation scores
{
CCLabelTTF * _sPlatesScore;
    CCLabelTTF * _totalScore;
    CCLabelTTF * _balloonScore;
    CCLabelTTF * _fPlatesScore;
    CCLabelTTF * _airPlaneScore;
    int totalpoint;

CCLabelTTF *_bestScore;
}

-(void)continue{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:0 forKey:@"_balloonScore"];
    [defaults setInteger:0 forKey:@"_fPlatesScore"];
    [defaults setInteger:0 forKey:@"_airPlaneScore"];
    [defaults setInteger:0 forKey:@"_targetScore"];
    [defaults synchronize];

    
    
    CCScene *scene = [CCBReader loadAsScene:@"balloon"];
    // [self stopAllActions];/*workaround for bug  in new spritebuilder/cocos3.1*/
    [[CCDirector sharedDirector] replaceScene:scene];
}
- (void)home {
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void)didLoadFromCCB {
   /* _sPlatesScore.string=0;
    _totalScore.string=0;
    _balloonScore.string=0;
    _fPlatesScore.string=0;
    _airPlaneScore.string=0;
    _bestScore.string=0;*/
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int b=(int)[defaults integerForKey:@"_cycleCount"];
    b=b+1;
    if(b==4)
        b=0;
    [defaults setInteger:b forKey:@"_cycleCount"];
    
    int x=(int)[defaults integerForKey:@"_targetScore"];
    _sPlatesScore.string = [NSString stringWithFormat:@"%d", x];
    
    int y=(int)[defaults integerForKey:@"_fPlatesScore"];
    _fPlatesScore.string = [NSString stringWithFormat:@"%d", y];
    
    int z=(int)[defaults integerForKey:@"_airPlaneScore"];
    _airPlaneScore.string = [NSString stringWithFormat:@"%d", z];
    int a=(int)[defaults integerForKey:@"_balloonScore"];
    _balloonScore.string = [NSString stringWithFormat:@"%d", a];
    
    totalpoint=a+x+y+z;
    _totalScore.string = [NSString stringWithFormat:@"%d", totalpoint];
    
    int bestTotal=(int)[defaults integerForKey:@"_bestTotal"];
    if(totalpoint>bestTotal||bestTotal==0) {
        bestTotal=totalpoint;
    }
    {
        [[GCHelper sharedInstance] reportScore:kLeaderboardEscape score:(int) bestTotal];
        NSLog(@"total points=%d",bestTotal);
        if(bestTotal>10){
            if (![GameState sharedInstance].completedLevel1) {
                [GameState sharedInstance].completedLevel1 = true;
                [[GameState sharedInstance] save];
                [[GCHelper sharedInstance] reportAchievement:kAchievementLevel1
                                             percentComplete:100.0];
            }
        }
        if(bestTotal>25){
            if (![GameState sharedInstance].completedLevel2) {
                [GameState sharedInstance].completedLevel2 = true;
                [[GameState sharedInstance] save];
                [[GCHelper sharedInstance] reportAchievement:kAchievementLevel2
                                             percentComplete:100.0];
            }
            
        }
        if(bestTotal>38){
            if (![GameState sharedInstance].completedLevel3) {
                [GameState sharedInstance].completedLevel3 = true;
                [[GameState sharedInstance] save];
                [[GCHelper sharedInstance] reportAchievement:kAchievementLevel3
                                             percentComplete:100.0];
            }
            
        }

    }
    _bestScore.string = [NSString stringWithFormat:@"%d", bestTotal];
    
    [defaults setInteger:bestTotal forKey:@"_bestTotal"];
    [defaults synchronize];

}
@end
