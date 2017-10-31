//
//  YFVoice.h
//  Dandre
//
//  Created by Dandre on 2016/11/1.
//  Copyright © 2016年 Dandre Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlyDataUploader.h"
#import "iflyMSC/IFlyContact.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"

@class YFVoice;
typedef void(^CWVoiceRecognizerBlock)(YFVoice *voice, NSString *result);

@interface YFVoice : NSObject <IFlyRecognizerViewDelegate>

#pragma mark - 语音输入视图
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@property (nonatomic, copy) NSString *text;


#pragma mark - 外部调用


/**
 单例

 @return 单例
 */
+ (instancetype)shareVoice;

/**
 开始聆听，识别语音

 @param block 识别后的回调
 */
- (void)startWithCallBack:(CWVoiceRecognizerBlock)block;

@end
