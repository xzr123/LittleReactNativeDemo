//
//  CallRNTest.m
//  ReactNativeTest
//
//  Created by 肖峥荣 on 2017/7/12.
//  Copyright © 2017年 肖峥荣. All rights reserved.
//

#import "CallRNTest.h"

@implementation CallRNTest

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"callRn"];//有几个就写几个
}

-(void)nativeCallRn:(NSString*)code result:(NSString*) result
{
    [self sendEventWithName:@"callRn"
                       body:@{
                              @"code": code,
                              @"result": result,
                              }];
}

RCT_EXPORT_METHOD(callMe){
    NSLog(@"RN call OC here!");
    [self nativeCallRn:@"200" result:@"OC call Rn"];
}

@end
