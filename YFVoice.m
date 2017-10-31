//
//  YFVoice.m
//  Dandre
//
//  Created by Dandre on 2016/11/1.
//  Copyright © 2016年 Dandre Inc. All rights reserved.
//

#import "YFVoice.h"

@implementation YFVoice
{
    CWVoiceRecognizerBlock      _block;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSpeechRecognizer];
    }
    return self;
}

#pragma mark - 单例
+ (instancetype)shareVoice
{
    static YFVoice *voice = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        voice = [[YFVoice alloc] init];
    });
    
    return voice;
}

#pragma mark - 开始聆听
- (void)startWithCallBack:(CWVoiceRecognizerBlock)block
{
    _block = block;
    [[UIApplication sharedApplication].delegate.window endEditing:YES];
    [self startListenning];
}

#pragma mark - 语音识别
- (void)setupSpeechRecognizer
{
    if (self.iflyRecognizerView == nil) {
        self.iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:kWindow.center];
        self.iflyRecognizerView.delegate = self;
        [self.iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        [self.iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        [self.iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        // MARK:设置语言
        // TODO:设置语言 中文 语言和方言可自己自定义设置，建议工程中对每次设置的语言类型进行本地化存储，这里只是简单设置一下
        [self.iflyRecognizerView setParameter:[IFlySpeechConstant LANGUAGE_CHINESE] forKey:[IFlySpeechConstant LANGUAGE]];
        // TODO:设置方言 普通话
        [self.iflyRecognizerView setParameter:[IFlySpeechConstant ACCENT_MANDARIN] forKey:[IFlySpeechConstant ACCENT]];
    }
    
    self.iflyRecognizerView.userInteractionEnabled = YES;
}

#pragma mark - 开始聆听
- (void)startListenning
{
    self.iflyRecognizerView.userInteractionEnabled = YES;
    [self.iflyRecognizerView start];
    NSLog(@"start listenning...");
}

#pragma mark - IFlyRecognizerViewDelegate

- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@", key];
    }
    
    self.text = result;
    
    if (_block) {
        _block(self, self.text);
    }
}

- (void)onError:(IFlySpeechError *)error
{
    DLog(@"errorDesc:%@", error.errorDesc);
}

@end
