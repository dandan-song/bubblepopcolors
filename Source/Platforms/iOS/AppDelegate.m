/*
 * SpriteBuilder: http://www.spritebuilder.org
 *
 * Copyright (c) 2012 Zynga Inc.
 * Copyright (c) 2013 Apportable Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "cocos2d.h"

#import "AppDelegate.h"
#import "CCBuilderReader.h"
#import "GCHelper.h"
#import "Appirater.h"
#import "GAI.h"
#import "Flurry.h"
@implementation AppController

-(void)createGoogleAnalytics
{
#if 1
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-58524697-14"];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    tracker.allowIDFACollection = NO;
#endif
    [Flurry startSession:@"DYHMXZBBDJPWCCSKHGJK"];
}
- (void) showInterstitial
{
 
    // Play a Vungle ad (with default options)
    VungleSDK* sdk = [VungleSDK sharedSDK];
    NSError *error;

    [sdk playAd:self.navController error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        showinter_ = TRUE;

    } else {
        showinter_ = FALSE;

    }
 
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    showinter_ = FALSE;

    NSString* appID = @"572a53e6faf583543500003e";
    VungleSDK* sdk = [VungleSDK sharedSDK];
    // start vungle publisher library
    [sdk startWithAppId:appID];
    [[VungleSDK sharedSDK] setDelegate:self];

    
    // Configure Cocos2d with the options set in SpriteBuilder
    NSString* configPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Published-iOS"]; // TODO: add support for Published-Android support
    configPath = [configPath stringByAppendingPathComponent:@"configCocos2d.plist"];
    
    NSMutableDictionary* cocos2dSetup = [NSMutableDictionary dictionaryWithContentsOfFile:configPath];
    
    // Note: this needs to happen before configureCCFileUtils is called, because we need apportable to correctly setup the screen scale factor.
#ifdef APPORTABLE
    if([cocos2dSetup[CCSetupScreenMode] isEqual:CCScreenModeFixed])
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenAspectFitEmulationMode];
    else
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenScaledAspectFitEmulationMode];
#endif
    
    // Configure CCFileUtils to work with SpriteBuilder
    [CCBReader configureCCFileUtils];
    
    // Do any extra configuration of Cocos2d here (the example line changes the pixel format for faster rendering, but with less colors)
    //[cocos2dSetup setObject:kEAGLColorFormatRGB565 forKey:CCConfigPixelFormat];
    
    [self setupCocos2dWithOptions:cocos2dSetup];

    [[GCHelper sharedInstance] authenticateLocalUser];
#if 1
    [self createGoogleAnalytics];

    /*appirater*/
    [Appirater setAppId:@"1025902822"];
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
#endif
    return YES;
}

- (CCScene*) startScene
{
    return [CCBReader loadAsScene:@"MainScene"];
}
#pragma mark - VungleSDK Delegate

- (void)vungleSDKAdPlayableChanged:(BOOL)isAdPlayable {
    if (isAdPlayable) {
        NSLog(@"An ad is available for playback");
        if (showinter_){
            
        [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(showInterstitial) userInfo:nil repeats:NO];      
             
        }
         /*if (!_showAdButton.enabled || !_showAdWithOptionsButton.enabled) {
            [self enableAdButtons:YES];
        }*/
        
    } else {
        NSLog(@"No ads currently available for playback");
        /*[self enableAdButtons:NO];*/
    }
 }

- (void)vungleSDKwillShowAd {
    NSLog(@"An ad is about to be played!");
    
    [OALSimpleAudio sharedInstance].bgMuted = YES;
    [OALSimpleAudio sharedInstance].bgPaused = YES;
    [[OALSimpleAudio sharedInstance] stopAllEffects];
    

    //Use this delegate method to pause animations, sound, etc.
}

- (void) vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
    if (willPresentProductSheet) {
        //In this case we don't want to resume animations and sound, the user hasn't returned to the app yet
        NSLog(@"The ad presented was tapped and the user is now being shown the App Product Sheet");
        NSLog(@"ViewInfo Dictionary:");
        for(NSString * key in [viewInfo allKeys]) {
            NSLog(@"%@ : %@", key, [[viewInfo objectForKey:key] description]);
        }
    } else {
        //In this case the user has declined to download the advertised application and is now returning fully to the main app
        //Animations / Sound / Gameplay can be resumed now
        NSLog(@"The ad presented was not tapped - the user has returned to the app");
        NSLog(@"ViewInfo Dictionary:");
        for(NSString * key in [viewInfo allKeys]) {
            NSLog(@"%@ : %@", key, [[viewInfo objectForKey:key] description]);
        }
        
        [OALSimpleAudio sharedInstance].bgMuted = NO;
        [OALSimpleAudio sharedInstance].bgPaused = NO;
        
 
    }
}

- (void)vungleSDKwillCloseProductSheet:(id)productSheet {
    NSLog(@"The user has downloaded an advertised application and is now returning to the main app");
    //This method can be used to resume animations, sound, etc. if a user was presented a product sheet earlier
    
    [OALSimpleAudio sharedInstance].bgMuted = NO;
    [OALSimpleAudio sharedInstance].bgPaused = NO;
    
}


@end
