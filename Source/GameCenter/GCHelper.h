//
//  GCHelper.h
//  SpaceViking
//
//  Created by Ray Wenderlich on 3/9/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

#define kAchievementLevel1 @"com.blogdns.songbird.BubblePopColors.achievement.level1"
#define kAchievementLevel2 @"com.blogdns.songbird.BubblePopColors.achievement.level2"
#define kAchievementLevel3 @"com.blogdns.songbird.BubblePopColors.achievement.level3"

#define kLeaderboardEscape @"com.blogdns.songbird.BubblePopColors.leaderboard"



@interface GCHelper : NSObject <NSCoding> {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    NSMutableArray *scoresToReport;
    NSMutableArray *achievementsToReport;
}

@property (retain) NSMutableArray *scoresToReport;
@property (retain) NSMutableArray *achievementsToReport;

+ (GCHelper *) sharedInstance;
- (void)authenticationChanged;
- (void)authenticateLocalUser;
- (void)save;
- (id)initWithScoresToReport:(NSMutableArray *)scoresToReport 
        achievementsToReport:(NSMutableArray *)achievementsToReport;
- (void)reportAchievement:(NSString *)identifier 
          percentComplete:(double)percentComplete;
- (void)reportScore:(NSString *)identifier score:(int)score;

@end
