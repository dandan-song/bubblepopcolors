//
//  GameState.m
//  SpaceViking
//
//  Created by Ray Wenderlich on 3/9/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "GameState.h"
#import "GCDatabase.h"

@implementation GameState
@synthesize completedLevel1;
@synthesize completedLevel2;
@synthesize completedLevel3;


static GameState *sharedInstance = nil;

+(GameState*)sharedInstance {
	@synchronized([GameState class]) 
	{
	    if(!sharedInstance) {
            sharedInstance = loadData(@"GameState");
            if (!sharedInstance) {
                [[self alloc] init]; 
            }
        }
	    return sharedInstance; 
	}
	return nil; 
}

+(id)alloc 
{
	@synchronized ([GameState class])
	{
		NSAssert(sharedInstance == nil, @"Attempted to allocate a \
                 second instance of the GameState singleton"); 
		sharedInstance = [super alloc];
		return sharedInstance; 
	}
	return nil;  
}

- (void)save {
    saveData(self, @"GameState");
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeBool:completedLevel1 forKey:@"CompletedLevel1"];
    [encoder encodeBool:completedLevel2 forKey:@"CompletedLevel2"];
    [encoder encodeBool:completedLevel3 forKey:@"CompletedLevel3"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {                
        completedLevel1 = [decoder 
                           decodeBoolForKey:@"CompletedLevel1"];
        completedLevel2 = [decoder 
                           decodeBoolForKey:@"CompletedLevel2"];
        completedLevel3 = [decoder 
                           decodeBoolForKey:@"CompletedLevel3"];
          }
    return self;
}

@end
