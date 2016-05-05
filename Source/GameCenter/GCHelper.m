//
//  GCHelper.m
//  SpaceViking
//
//  Created by Ray Wenderlich on 3/9/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "GCHelper.h"
#import "GCDatabase.h"
#import "CCDirector.h"

@implementation GCHelper
@synthesize scoresToReport;
@synthesize achievementsToReport;

#pragma mark Loading/Saving

static GCHelper *sharedHelper = nil;
+ (GCHelper *) sharedInstance {
    @synchronized([GCHelper class]) 
    {
        if (!sharedHelper) {
            sharedHelper = loadData(@"GameCenterData") ;
            if (!sharedHelper) {
                [[self alloc] 
                 initWithScoresToReport:[NSMutableArray array] 
                 achievementsToReport:[NSMutableArray array]];
            }
        }
        return sharedHelper;
    }
    return nil;
}

+(id)alloc 
{
	@synchronized ([GCHelper class])
	{
		NSAssert(sharedHelper == nil, @"Attempted to allocated a \
                 second instance of the GCHelper singleton");
		sharedHelper = [super alloc];
		return sharedHelper;
	}
	return nil;  
}

- (void)save {
    saveData(self, @"GameCenterData");
}

- (BOOL)isGameCenterAvailable {
	// check for presence of GKLocalPlayer API
	Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
	// check if the device is running iOS 4.1 or later
	NSString *reqSysVer = @"4.1";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer 
                                           options:NSNumericSearch] != NSOrderedAscending);
	
	return (gcClass && osVersionSupported);
}

- (id)initWithScoresToReport:(NSMutableArray *)theScoresToReport 
        achievementsToReport:(NSMutableArray *)theAchievementsToReport {
    if ((self = [super init])) {
        self.scoresToReport = theScoresToReport;
        self.achievementsToReport = theAchievementsToReport;
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = 
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self 
                   selector:@selector(authenticationChanged) 
                       name:GKPlayerAuthenticationDidChangeNotificationName 
                     object:nil];
            [nc addObserver:self selector:@selector(pause) name:UIWindowDidResignKeyNotification object:nil];
            [nc addObserver:self selector:@selector(resume) name:UIWindowDidBecomeKeyNotification object:nil];

        }
    }
    return self;
}

#pragma mark Internal functions

- (void)sendScore:(GKScore *)score {
    [score reportScoreWithCompletionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void)
                       {
                           if (error == NULL) {
                               NSLog(@"Successfully sent score!");
                               [scoresToReport removeObject:score];                
                           } else {
                               NSLog(@"Score failed to send... will try again later.  Reason: %@", error.localizedDescription);                
                           }
                       });
    }];
}
-(void) pause
{
    [[CCDirector sharedDirector] pause];
}
-(void) resume
{
    [[CCDirector sharedDirector] resume];
}

- (void)sendAchievement:(GKAchievement *)achievement {
    [achievement reportAchievementWithCompletionHandler:
     ^(NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^(void)
                        {
                            if (error == NULL) {
                                NSLog(@"Successfully sent archievement!");
                                [achievementsToReport removeObject:achievement];                
                            } else {
                                NSLog(@"Achievement failed to send... will try again \
                                      later.  Reason: %@", error.localizedDescription);                
                            }
                        });
     }];
}

- (void)resendData {
    for (GKAchievement *achievement in achievementsToReport) {
        [self sendAchievement:achievement];
    }
    for (GKScore *score in scoresToReport) {
        [self sendScore:score];
    }    
}

- (void)authenticationChanged {    
    dispatch_async(dispatch_get_main_queue(), ^(void) 
                   {
                       if ([GKLocalPlayer localPlayer].isAuthenticated && 
                           !userAuthenticated) {
                           NSLog(@"Authentication changed: player authenticated.");
                           userAuthenticated = TRUE;    
                           [self resendData];
                       } else if (userAuthenticated) {
                           NSLog(@"Authentication changed: player not authenticated");
                           userAuthenticated = FALSE;
                       }
//                        [[CCDirector sharedDirector] resume];
                   });
}
#pragma mark User functions

- (void)authenticateLocalUser { 
    
    if (!gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[CCDirector sharedDirector] pause];
        [[GKLocalPlayer localPlayer] 
         authenticateWithCompletionHandler:^(NSError* error)
        {
            //lasterror = error;
            [[CCDirector sharedDirector] resume];
        }];
   
    } else {
        NSLog(@"Already authenticated!");
    }
}

- (void)reportScore:(NSString *)identifier score:(int)rawScore {
    
    GKScore *score = [[GKScore alloc]
                       initWithCategory:identifier] ;
    score.value = rawScore;
    [scoresToReport addObject:score];
    [self save]; 
    
    if (!gameCenterAvailable || !userAuthenticated) return;
    [self sendScore:score];
    
}


- (void)reportAchievement:(NSString *)identifier 
          percentComplete:(double)percentComplete {    
    
    GKAchievement* achievement = [[GKAchievement alloc]
                                   initWithIdentifier:identifier];
    achievement.percentComplete = percentComplete;
    [achievementsToReport addObject:achievement];    
    [self save]; 
    
    if (!gameCenterAvailable || !userAuthenticated) return;
    [self sendAchievement:achievement];    
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:scoresToReport forKey:@"ScoresToReport"];
    [encoder encodeObject:achievementsToReport 
                   forKey:@"AchievementsToReport"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSMutableArray * theScoresToReport = 
    [decoder decodeObjectForKey:@"ScoresToReport"];
    NSMutableArray * theAchievementsToReport = 
    [decoder decodeObjectForKey:@"AchievementsToReport"];
    return [self initWithScoresToReport:theScoresToReport 
                   achievementsToReport:theAchievementsToReport];
}

@end
