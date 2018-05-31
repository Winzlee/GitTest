//
//  WZMusicHelperMusicHelper.h
//  Winzlee
//
//  Created by liwenzhi on 14-11-28.
//  Copyright (c) 2014年 lwz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface WZMusicHelper : NSObject

// 加载音效
+ (SystemSoundID)loadSystemSoundsWithFileName:(NSString *)fileName;
// 加载背景音乐
+ (AVAudioPlayer *)loadBgMusicWithFileName:(NSString *)fileName;
@end
