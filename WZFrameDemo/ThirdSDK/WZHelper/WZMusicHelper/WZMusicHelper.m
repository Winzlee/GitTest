//
//  WZMusicHelper.m
//  Winzlee
//
//  Created by liwenzhi on 14-11-28.
//  Copyright (c) 2014年 lwz. All rights reserved.
//

#import "WZMusicHelper.h"

@implementation WZMusicHelper


// 加载背景音乐
+ (AVAudioPlayer *)loadBgMusicWithFileName:(NSString *)fileName
{
    // 获取音乐地址
    NSError *error;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        NSLog(@"%@",error.description);
    }
    
    [player prepareToPlay];
    
    return player;
 
}

// 加载音效
+ (SystemSoundID)loadSystemSoundsWithFileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    SystemSoundID soundId;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    
    
    return soundId;
}



@end
