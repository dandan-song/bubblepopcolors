//
//  pQ.m
//  BubblePopColors
//
//  Created by Dandan Song on 7/31/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "pQ.h"
#import"MainScene.h"


@implementation pQ{

CCLabelTTF *_answerLabel;
CCLabelTTF *_qestionLable;
    CCLabelTTF *_right;
   CCLabelTTF * _wrong;
   
    
    int c;
    int z;
}

- (void)didLoadFromCCB {
    self.right1=0;
    
    c=0;
    _numberStack=0;
    _right.visible=false;
    _wrong.visible=false;
    _answerLabel.string = [NSString stringWithFormat:@""];
    _qestionLable.string = [NSString stringWithFormat:@""];

    _urlText=@"";
    
}

- (void) showContent{
    
    int r1,r2;
    r1=arc4random() % 20;
    if (r1<10) {
        r2=10+arc4random() % (10-r1);
    }
    if (r1>=10) {
        r2=arc4random() % (20-r1);
    }
    _qestionLable.string = [NSString stringWithFormat:@"%ld + %ld = ", (long)r1,(long)r2 ];
    _answerLabel.string = [NSString stringWithFormat:@""];
    z=r1+r2;
    c=0;
    _numberStack=0;
    _right.visible=false;
    _wrong.visible=false;
    self.visible=true;
    [self stopAllActions];


}
- (void)zero {
    [self addnumber:0];
   
   }
- (void)one {
    [self addnumber:1];
}

- (void)two {
    [self addnumber:2];
}

- (void)three {
    [self addnumber:3];
}

- (void)four {
    [self addnumber:4];
}

- (void)five {
    [self addnumber:5];
}

- (void)six{
    [self addnumber:6];
}

- (void)seven{
    [self addnumber:7];
}

- (void)eight{
    [self addnumber:8];
}

- (void)nine {
    [self addnumber:9];
}

- (void)cancle{
    self.visible=false;

    
}

-(void)addnumber:(int)number{
   
    if ((c==2)&&(_numberStack==z)){
    return;}
    if ((c==2)&&(_numberStack!=z)){
    c=0;
    _numberStack=0;
        _right.visible=false;
        _wrong.visible=false;

    }
    
    _numberStack=_numberStack*10+number;
    _answerLabel.string = [NSString stringWithFormat:@"%ld", (long)_numberStack];
    if((c==1)&&(_numberStack==z))
    {
        //self.visible=false;
    
        _right.visible=true;
        _wrong.visible=false;
        self.right1=1;
        __weak typeof(self) weakSelf = self;
        __block BOOL blockDidRun = NO;
        
        id callBlock = [CCActionCallBlock actionWithBlock:^{
            if (blockDidRun == NO) {
                blockDidRun = YES;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlText]];
                self.visible=false;
                [self stopAllActions];
                
            }
        }];
        id delay = [CCActionDelay actionWithDuration:1.5];
        
        
        id sequence = [CCActionSequence actions:delay, callBlock, nil];
        [self runAction:sequence];

    }
   if((c==1)&&(_numberStack!=z)){
        _right.visible=false;
        _wrong.visible=true;
   }
    
        c++;
    }


@end
