//
//  MainScene.m
//  shootingGame
//
//  Created by Dandan Song on 4/1/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "GCHelper.h"
#import "AppDelegate.h"
#import "pQ.h"
@implementation MainScene
{
    CCNode*_bubble11;
    CCNode*_bubble15;
    CCNode*_bubble16;
    CCNode*_bubble17;
    CCNode*_bubble18;
    CCNode*_bubble19;
    CCNode*_bubble20;
    CCNode*_bubble21;
    CCNode*_bubble22;
    CCNode*_bubble13;
    CCNode*_moregames;
    CGPoint bubble11Position;
    CGPoint bubble15Position;
    CGPoint bubble13Position;
     CGPoint bubble16Position;
     CGPoint bubble17Position;
     CGPoint bubble18Position;
     CGPoint bubble19Position;
     CGPoint bubble20Position;
     CGPoint bubble21Position;
     CGPoint bubble22Position;
 // pQ*_pq;
   pQ *_pQ;
    
}
- (void)didLoadFromCCB {
    _pQ.visible=false;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int x=0;
     
    [defaults setInteger:0 forKey:@"_balloonScore"];
    [defaults setInteger:0 forKey:@"_fPlatesScore"];
    [defaults setInteger:0 forKey:@"_airPlaneScore"];
    [defaults setInteger:0 forKey:@"_targetScore"];
 
    [defaults setInteger:x forKey:@"_cycleCount"];
    [defaults setInteger:1 forKey:@"_tutorial"];

    [defaults synchronize];

    _bubble11.physicsBody.affectedByGravity=NO;
    _bubble13.physicsBody.affectedByGravity=NO;
    _bubble15.physicsBody.affectedByGravity=NO;
     _bubble16.physicsBody.affectedByGravity=NO;
     _bubble17.physicsBody.affectedByGravity=NO;
     _bubble18.physicsBody.affectedByGravity=NO;
     _bubble19.physicsBody.affectedByGravity=NO;
     _bubble20.physicsBody.affectedByGravity=NO;
     _bubble21.physicsBody.affectedByGravity=NO;
     _bubble22.physicsBody.affectedByGravity=NO;
    

    bubble11Position=_bubble11.position;
    bubble13Position=_bubble13.position;
     bubble15Position=_bubble15.position;
    bubble16Position=_bubble16.position;
    bubble17Position=_bubble17.position;
    bubble18Position=_bubble18.position;
    bubble19Position=_bubble19.position;
    bubble20Position=_bubble20.position;
    bubble21Position=_bubble21.position;
    bubble22Position=_bubble22.position;
    _moregames.visible= NO;
    /*show advertisement*/
    AppController *ac = (AppController *)[UIApplication sharedApplication].delegate;
    [ac showInterstitial ];


}
-(void)parentalLife{
    [self stopAllActions];
    [_pQ showContent];
    __weak typeof(self) weakSelf = self;
    __block BOOL blockDidRun = NO;
    
    id callBlock = [CCActionCallBlock actionWithBlock:^{
        if (blockDidRun == NO) {
            blockDidRun = YES;
           
            [self stopAllActions];
            _pQ.visible=false;
            
        }
    }];
    id delay = [CCActionDelay actionWithDuration:10.0];
    
    
    id sequence = [CCActionSequence actions:delay, callBlock, nil];
    [self runAction:sequence];

}




-(void)buble{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/bubble-pop-letters-numbers/id989571713?ls=1&mt=8";
  
   [self parentalLife];
}

-(void)math{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/math-targeselft-shooting/id1016318658?ls=1&mt=8";
    
    [self parentalLife];
    
}

-(void)sqRhyming{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/squirrel-rhyming-words/id720147933?ls=1&mt=8";
   
    [self parentalLife];

}

-(void)rhymTarget{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/rhyming-words-target-shooting/id984941228?ls=1&mt=8";

    [self parentalLife];

}
-(void)farmer{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/2048-farmer-in-the-dell/id995632824?ls=1&mt=8";
 
    [self parentalLife];
}

-(void)runBunny{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/run-bunny-home-kids/id964707205?ls=1&mt=8";
    
    [self parentalLife];

}
-(void)pBunny{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/proud-bunny/id602524213?ls=1&mt=8";

    [self parentalLife];

}
-(void)sight{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/squirrel-sight-words/id721094681?ls=1&mt=8";

    [self parentalLife];
}
-(void)ghost{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/fight-with-ghosts/id816087904?ls=1&mt=8";

    [self parentalLife];

}
-(void)sgLetters{
    _pQ.urlText=@"itms-apps://itunes.apple.com/us/app/squirrel-letters-numbers-shapes/id698547455?ls=1&mt=8";

    [self parentalLife];

}

-(void)more{
    _bubble11.position=bubble11Position;
    _bubble15.position=bubble15Position;
    _bubble13.position=bubble13Position;
    _bubble16.position=bubble16Position;
    _bubble17.position=bubble17Position;
    _bubble18.position=bubble18Position;
    _bubble19.position=bubble19Position;
    _bubble20.position=bubble20Position;
    _bubble21.position=bubble21Position;
    _bubble22.position=bubble22Position;
    _moregames.visible= YES;
#if 0
    _bubble13.visible=true;
    _bubble15.visible=true;
    _bubble11.visible=true;
    _bubble16.visible=true;
    _bubble17.visible=true;
    _bubble18.visible=true;
    _bubble19.visible=true;
    _bubble20.visible=true;
    _bubble21.visible=true;
    _bubble22.visible=true;
#endif
    _bubble11.physicsBody.affectedByGravity=YES;
    _bubble15.physicsBody.affectedByGravity=YES;
    _bubble13.physicsBody.affectedByGravity=YES;
    _bubble16.physicsBody.affectedByGravity=YES;
    _bubble17.physicsBody.affectedByGravity=YES;
    _bubble18.physicsBody.affectedByGravity=YES;
    _bubble19.physicsBody.affectedByGravity=YES;
    _bubble20.physicsBody.affectedByGravity=YES;
    _bubble21.physicsBody.affectedByGravity=YES;
    _bubble22.physicsBody.affectedByGravity=YES;
    

   
   }


-(void)start{
    NSString *startscene=@"balloon";
    //startscene=@"targetScene";/*for debug pick different startscene*/
    CCScene *scene = [CCBReader loadAsScene: startscene];
    
    // [self stopAllActions];/*workaround for bug  in new spritebuilder/cocos3.1*/
    [[CCDirector sharedDirector] replaceScene:scene];
}
-(void)displayLeaderboard
{
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [app.navController presentModalViewController:leaderboardViewController animated:YES];
}
-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [app.navController dismissModalViewControllerAnimated:YES];
    [[CCDirector sharedDirector] resume];//bug workaround
    
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [app.navController dismissModalViewControllerAnimated:YES];
    [[CCDirector sharedDirector] resume];//bug workaround
    
}

@end
