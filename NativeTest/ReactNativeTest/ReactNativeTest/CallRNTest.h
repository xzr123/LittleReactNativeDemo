//
//  CallRNTest.h
//  ReactNativeTest
//
//  Created by 肖峥荣 on 2017/7/12.
//  Copyright © 2017年 肖峥荣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTEventEmitter.h"

@interface CallRNTest : RCTEventEmitter<RCTBridgeModule>

//公开调用接口，供其他地方使用
-(void)nativeCallRn:(NSString*)code result:(NSString*) result;

@end
