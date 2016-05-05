//
//  plate.m
//  shootingGame
//
//  Created by Dandan Song on 3/24/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "plates.h"
#import "CCDragSprite.h"
#import "plate.h"

#define ARC4RANDOM_MAX      0x100000000
#define PLAYAUDIO 1
static const CGFloat scrollSpeed = 0.f;
static NSString * const thisSceneName = @"platesScene";
static NSString * const nextSceneName = @"airPlanes";
static NSString * const scoreName= @"_fPlatesScore";
static NSString * const qName= @"_fPlatesQ";

static const int choiceColor = 0;

static const int choiceShape = 1;

static const int choiceNumber = 2;

static const int choiceLetter = 3;


@implementation plates
{
    int BulletCount;
    int  scenechange;

    int maxnumber;
    int choice;
    NSMutableArray *colors;
    NSMutableArray *shapes;
    
    NSInteger _points;
    CCLabelTTF *_scoreLabel;
    CCPhysicsNode *_physicsNode;
    CCNode *_scopeAdj;
    NSArray *_balloons;
    
    
    CCNode *_snow;
    CCNode *_snowCloud;
    CCNode *_white;
    CCNode *_day;
    CCNode *_night;
    
    ccColor3B * colorshades;
    
    CCNode *_plate1;
    CCNode *_plate2;
    CCNode *_plate3;
    CCNode *_plate4;
    CCNode *_plate5;
    CCNode *_plate6;
    CCNode *_plate7;
    CCNode *_plate8;
    CCNode *_plate9;
    CCNode *_plate10;
    CCNode *_plate11;
    CCNode *_plate12;

    
    NSMutableArray *imageNamesArray;
    NSMutableArray *extraimageNamesArray;
    NSMutableArray *tagNameArray1;
    NSMutableArray *tagNameArray;
    NSMutableArray *cheeseArray;
    
    NSMutableDictionary *cheeseName;
    
    NSNumber * match_tag1;
    //int * match_tag;
    NSString * match_name;
    CCLabelTTF*cheese;
    bool questionplaying;
    bool primed;
    bool doshot;

}

typedef NS_ENUM(NSInteger, DrawingOrder) {
    
    DrawingOrderBalloons,
    
    DrawingOrderGround,
    
    DrawingOrdeScope
};

- (void)home {
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

-(void) setupScore{
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    CCColor *shirtColor;
    int fs = 36;
    if (choice==choiceLetter || choice==choiceNumber){
        fs = 54;
    }
    cheese = [CCLabelTTF labelWithString: match_name
                                fontName:@"MarkerFelt-Thin"
                                fontSize:fs]; //use this label as your cheese
    
    
    /*cheese= [loader createSpriteWithUniqueName:match_name parent:nil];*/
    cheese.position = ccp((s.width / 100) +( cheese.contentSize.width/2), s.height*.91);
    [self addChild:cheese z:20];
    [cheese setVisible:YES];
    if (choice == choiceColor) {
        ccColor3B  cs =colorshades[ [match_tag1 intValue]];
        shirtColor = [CCColor colorWithRed: cs.r/255.0 green:cs.g/255.0 blue:cs.b/255.0 ];
        [cheese setColor:shirtColor];
    } else {
        [cheese setOutlineColor:[CCColor blackColor]];
        
    }
    if (choice==choiceShape) {
        CCSprite *sprshape = (CCSprite *)[CCBReader load: match_name  ];
        [self addChild:sprshape z:20];
        sprshape.position = ccp((s.width / 100) +( sprshape.contentSize.width/2) +cheese.contentSize.width +5, s.height*.91);
        //[sprshape setColor:shirtColor];
        [sprshape setVisible:YES];
        
    }
}


- (void)spawnNewObstacle {
    
         int reqmatch=BulletCount;
    _balloons=@[_plate1, _plate2, _plate3, _plate4,_plate5,_plate6,_plate7,_plate8,_plate9,_plate10,_plate11,_plate12];
    int remcount =_balloons.count;
    for (CCNode *_balloon1 in _balloons) {
        int r10;
        r10=arc4random() % 2;  //we want to use the extra array to pick a prefered word 20% of the time
        NSString* myRandomSpriteName;
        NSNumber* myRandomTagName;
        if ((reqmatch >0)&&((r10 == 0) ||(remcount <=reqmatch))) {
            // int r = arc4random() % [extraimageNamesArray count];
            myRandomSpriteName = match_name;
            myRandomTagName = match_tag1;//extra ones are this tag
            reqmatch--;
        }else {
            int r = arc4random() % [imageNamesArray count];
            myRandomSpriteName = [imageNamesArray objectAtIndex:r];
            
            
            myRandomTagName = [NSNumber numberWithInt:r]  ;
            if ( [myRandomTagName intValue] %26 == [match_tag1 intValue]%26)  {
                reqmatch--;
            }
            
        }
        remcount--;

        
        
        
        plate* _balloon;
        _balloon=(plate*)_balloon1;
        [_balloon setMyscene:self];
        
        _balloon.words=myRandomSpriteName;
        _balloon.tag=myRandomTagName;
        
        double red1 = ((double)arc4random() / ARC4RANDOM_MAX);
        double green1 = ((double)arc4random() / ARC4RANDOM_MAX);
        double blue1 = ((double)arc4random() / ARC4RANDOM_MAX);
        
        CCColor *  shirtColor = [CCColor colorWithRed: red1 green:green1 blue:blue1];
        if (choice == choiceColor) {
            ccColor3B  cs =colorshades[ [myRandomTagName intValue]];
            shirtColor = [CCColor colorWithRed: cs.r/255.0 green:cs.g/255.0 blue:cs.b/255.0 ];
        }
        [_balloon.platef setColor: shirtColor];
        
        
        cheese=_balloon.word;
        [cheese setString:myRandomSpriteName];
        [cheese setOutlineColor:shirtColor];
        if (choice==choiceColor){
            [cheese setColor:shirtColor];
        }
        if (choice==choiceLetter ||choice== choiceNumber) {
            [cheese setFontSize:50.0];
        }
        if (choice==choiceShape){
            //shapes= [NSMutableArray arrayWithObjects:@"square",@"triangle",@"circle",@"rectangle", @"oval", @"diamond", nil];
            int tag = [myRandomTagName intValue];
            switch(tag) {
                case 0:
                    _balloon.square.visible=true;
                    [_balloon.square setColor:shirtColor];
                    break;
                case 1:
                    _balloon.triangle.visible=true;
                    [_balloon.triangle setColor:shirtColor];
                    
                    break;
                case 2:
                    _balloon.circle.visible=true;
                    [_balloon.circle setColor:shirtColor];
                    
                    break;
                case 3:
                    _balloon.rectangle.visible=true;
                    [_balloon.rectangle setColor:shirtColor];
                    
                    break;
                case 4:
                    _balloon.oval.visible=true;
                    [_balloon.oval setColor:shirtColor];
                    
                    break;
                case 5:
                    _balloon.diamond.visible=true;
                    [_balloon.diamond setColor:shirtColor];
                    
                    break;
                    
            }
        }
    }
    
}


-(void) setupQuestion
{
    if([[OALSimpleAudio sharedInstance] bgPlaying]){
        return;
    }
    questionplaying=false;
    NSString* segmentName;

    if (choice==choiceLetter){
        segmentName = [NSString stringWithFormat:@"%@.m4a", [match_name uppercaseString]];
    } else {
        segmentName= [NSString stringWithFormat:@"%@.m4a", match_name];
        
    }
    [[OALSimpleAudio sharedInstance] playEffect: segmentName];
    
    
}


- (void)didLoadFromCCB {
    
    primed = NO;
    doshot = NO;
    scenechange = 0;

    maxnumber=14;
    
    //_score=0;
    [_plate1.animationManager runAnimationsForSequenceNamed:@"turn"]; /*also have word*/
    [_plate2.animationManager runAnimationsForSequenceNamed:@"turn"];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int b=(int)[defaults integerForKey:@"_cycleCount"];
    if(b==0){
        
        _day.visible=true;
        _white.visible=true;
        _snow.visible=false;
        _snowCloud.visible=false;
        _night.visible=false;
    }
    if((b>0)&&(b<2))
    {
        _day.visible=true;
        _white.visible=true;
        _snow.visible=true;
        _snowCloud.visible=true;
        _night.visible=false;
        
    }
    if((b>1)&&(b<3))
    {
        _white.visible=false;
        _day.visible=false;
        _night.visible=true;
        _snow.visible=false;
        _snowCloud.visible=false;
    }
    if((b>2)&&(b<4))
    {
        _white.visible=false;
        _day.visible=false;
        _night.visible=true;
        _snow.visible=true;
        _snowCloud.visible=true;
    }

    BulletCount=5;
    match_name=@"match";
    
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    //[self setupScore];
    _scopeAdj.zOrder = DrawingOrdeScope;
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    
    
    _balloons = [NSMutableArray array];
    
    
    cheeseArray= [NSMutableArray arrayWithCapacity:100];
    cheeseName= [NSMutableDictionary dictionaryWithCapacity:100];
    
    
    extraimageNamesArray= [NSMutableArray arrayWithCapacity:50];
    ccColor3B myPink = {255 ,	192, 	203};
    ccColor3B myPurple= {128, 	0, 	128};
    ccColor3B myBrown = {165, 	42, 	42};
    ccColor3B myOrange ={255 ,	165 ,	0};
    shapes= [NSMutableArray arrayWithObjects:@"square",@"triangle",@"circle",@"rectangle", @"oval", @"diamond", nil];
    colors=[NSMutableArray arrayWithObjects:@"red",@"green",@"blue",@"yellow",@"pink", @"purple", @"orange",@"black", @"white",@"gray", @"brown", nil];
    ccColor3B colorshades1[]=  { ccRED,ccGREEN, ccBLUE, ccYELLOW, myPink, myPurple,myOrange,ccBLACK,ccWHITE,ccGRAY,myBrown};
    colorshades=malloc(sizeof(colorshades1));
    memcpy(colorshades,colorshades1,sizeof(colorshades1)); /*copy the color array*/
    
    cheeseName= [NSMutableDictionary dictionaryWithCapacity:100];
    //[cheeseName retain];
    imageNamesArray= [NSMutableArray arrayWithCapacity:26];
    
    
    
    choice=arc4random() % 4;
    choice=choiceColor;

    //choice=1;
    if (choice==0){
      [[OALSimpleAudio sharedInstance] playBg:@"PleaseFindColor.m4a" ];
        for(NSString* color in colors){
            NSString *nameString=[NSString stringWithFormat:@"%@", color];
            [imageNamesArray addObject:nameString];
        }
        
    }
    else  if (choice==1){
      [[OALSimpleAudio sharedInstance] playBg:@"PleaseFindShape.m4a" loop:false];
        for(NSString* shape in shapes){
            NSString *nameString=[NSString stringWithFormat:@"%@", shape];
            [imageNamesArray addObject:nameString];
        }
    }
    else  if (choice==2){
        
      [[OALSimpleAudio sharedInstance] playBg:@"PleaseFindNumber.m4a" loop:false];
        
        for(int c= 0; c<=maxnumber; c++){
            NSString *nameString=[NSString stringWithFormat:@"%d", c];
            [imageNamesArray addObject:nameString];
        }
        
    }else
    {
        
      [[OALSimpleAudio sharedInstance] playBg:@"PleaseFindLetter.m4a" loop:false];
        
        
        for(int c= 'A'; c<='Z'; c++){
            NSString *nameString=[NSString stringWithFormat:@"%c", c];
            [imageNamesArray addObject:nameString];
            
            NSString *nameStringsmall=[NSString stringWithFormat:@"%c", c -'A' +'a'];
            [imageNamesArray addObject:nameStringsmall];
            
            
        }
    }
    
    
    int r1 = arc4random() % [imageNamesArray count];
    
    //r1=300;
    NSString* myRandomSpriteName1 = [imageNamesArray objectAtIndex:r1];

    match_name=myRandomSpriteName1;
    match_tag1= [NSNumber numberWithInt:r1];/*just use r1 the index as the tag*/
    
    
    questionplaying=true;
    [self setupQuestion];
    
    [self setupScore];
    [self spawnNewObstacle];
    
    
    
}

-(void)airplane{
    CCScene *scene = [CCBReader loadAsScene:@"airPlanes"];
    // [self stopAllActions];/*workaround for bug  in new spritebuilder/cocos3.1*/
    [[CCDirector sharedDirector] replaceScene:scene];
}


- (void)restart {
    // [self stopTimer];
    // timerCount=0;
    CCScene *scene = [CCBReader loadAsScene:@"platesScene"];
    // [self stopAllActions];/*workaround for bug  in new spritebuilder/cocos3.1*/
    [[CCDirector sharedDirector] replaceScene:scene];
}




- (void)update:(CCTime)delta {
    if(BulletCount==0){
        int dorestart = 0;
        if (scenechange) {
            return;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int _targetScore=(int)[defaults integerForKey:scoreName];
        int _targetQ=(int)[defaults integerForKey:qName];
        _targetScore=_targetScore+(int)_points;
        if((_targetQ==2)||(_targetQ>2)){
            _targetQ=1;
            scenechange = 1;
        }
        
        else {
            
            _targetQ=_targetQ+1;
            dorestart  = 1;
            scenechange = 1;/*reset is now delayed also*/
            
        }
        [defaults setInteger:_targetQ forKey:qName];
        [defaults setInteger:_targetScore forKey:scoreName];
        [defaults synchronize];
        if (dorestart){
            __weak typeof(self) weakSelf = self;
            
            id callBlock = [CCActionCallBlock actionWithBlock:^{
                CCLOG(@"restart scene");
                /*weakSelf.rotation += 90;*/
                //put something here to change the scene
                [self restart];
                
            }];
            id delay = [CCActionDelay actionWithDuration:2.0];
            //NSArray* actionsArray = @[delay, action2, action3];
            // NSArray* actionsArray = @[delay, callBlock];
            //id sequence = [CCActionSequence actionsWithArray:actionsArray];
            
            id sequence = [CCActionSequence actions:delay, callBlock, nil];
            [self runAction:sequence];
            
            
        } else {
#if 0
            [self stopAllActions];
            CCScene *scene = [CCBReader loadAsScene:nextSceneName];
            [[CCDirector sharedDirector] replaceScene:scene];
#endif
            
            __weak typeof(self) weakSelf = self;
            __block BOOL blockDidRun = NO;
            
            id callBlock = [CCActionCallBlock actionWithBlock:^{
                if (blockDidRun == NO) {
                    blockDidRun = YES;
                    CCLOG(@"change scene");
                    /*weakSelf.rotation += 90;*/
                    //put something here to change the scene
                    [self stopAllActions];
                    CCScene *scene = [CCBReader loadAsScene:nextSceneName];
                    [[CCDirector sharedDirector] replaceScene:scene];
                    
                }
            }];
            id delay = [CCActionDelay actionWithDuration:2.0];
            
            id sequence = [CCActionSequence actions:delay, callBlock, nil];
            [self runAction:sequence];
            
            
        }
        
    }
    
    
    _scopeAdj.position = ccp(_scopeAdj.position.x + delta * scrollSpeed, _scopeAdj.position.y);
    _physicsNode.position = ccp(_physicsNode.position.x - (scrollSpeed *delta), _physicsNode.position.y);
    //[self removeBalloons];
   if (questionplaying){
        [self setupQuestion];
    }
   
}

- (void)balloontouch:(plate*) _balloon1
{
    if (BulletCount <=0){
        return;     }
    if (([_balloon1.tag intValue] %26 == [match_tag1 intValue]%26)&& (_balloon1.balloonHit == 1)){
        
        //  [audio playEffect:@"candyDrop.wav"];
        CCParticleSystem *hitRight = (CCParticleSystem *)[CCBReader load:@"hitRight"];
        // make the particle effect clean itself up, once it is completed
        hitRight.autoRemoveOnFinish = TRUE;
        // place the particle effect on the seals position
        hitRight.positionInPoints = _balloon1.positionInPoints;
        // add the particle effect to the same node the seal is on
        [_balloon1.parent addChild:hitRight];
        
        
        _points++;
        
        _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)_points];
    }
    BulletCount--;
    
    //[self.myscene balloontouch:self];
    
    // CGPoint touchLocation = [touch locationInNode:self];
    
    CCParticleSystem *Bexplosion = (CCParticleSystem *)[CCBReader load:@"explosion"];
    
    Bexplosion.autoRemoveOnFinish = TRUE;
    Bexplosion.positionInPoints = _balloon1.positionInPoints;
 
    [self.parent addChild:Bexplosion z:10];
    _balloon1.visible=false;
    return;
    
    
}





@end
