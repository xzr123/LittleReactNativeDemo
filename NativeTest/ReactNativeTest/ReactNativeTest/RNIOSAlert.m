//
//  RNIOSAlert.m
//  ReactNativeTest
//
//  Created by 肖峥荣 on 2017/7/5.
//  Copyright © 2017年 肖峥荣. All rights reserved.
//

#import "RNIOSAlert.h"
#import "RCTConvert.h"

@interface RNIOSAlert()<UIAlertViewDelegate>

@property (nonatomic, strong) RCTResponseSenderBlock alertCallback;

@end

@implementation RNIOSAlert

//自动注册一个Module,当Object-c Bridge加载的时候。这个Module可以在JavaScript Bridge中调用。
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showAlert:(NSString *)msg){
//    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"react-native" message:msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alertView show];
//    });
    
    NSLog(@"msg:%@",msg);
}

RCT_EXPORT_METHOD(showTime:(NSDictionary*)dict){
    NSDate * date =[RCTConvert NSDate:dict[@"time"]];
    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"react-native" message:[date description] delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alertView show];
}

RCT_EXPORT_METHOD(showAlertAndCallback:(RCTResponseSenderBlock)callback){
    _alertCallback=callback;
    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"react-native" message:@"是否继续？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"继续", nil];
    [alertView show];
}

//表示该模块下得所有方法均在指定线程下运行
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  if (buttonIndex == 0) {
    _alertCallback(@[@"cancel"]);
  }else{
    _alertCallback(@[[NSNull null],@"call back from native"]);
  }
}

@end
