//
//  ViewController.m
//  ReactNativeTest
//
//  Created by 肖峥荣 on 2017/6/29.
//  Copyright © 2017年 肖峥荣. All rights reserved.
//

#import "ViewController.h"
#import "RCTRootView.h"

#import "CallRNTest.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,RCTBridgeDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSURL *jsCodeLocation;
@property (nonatomic, strong) RCTBridge *bridge;

@property (nonatomic, strong) RCTRootView *rootView;

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _array = @[@"Hello World",@"ParamPass" ,@"Alert", @"AlertCallback",@"CallRn"];
    
    //使用保留的 RCTBridge 初始化 RCTRootView 更节省资源，不用每次初始化bridge
    _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
    
    _score = 0;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifi"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifi"];
    }
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [self helloWorldClicked];
            break;
        case 1:
            [self paramPassClicked];
            break;
        case 2:
            [self logClicked];
            break;
        case 3:
            [self alertCallbackClicked];
            break;
        case 4:
            [self callRnClicked];
            break;
        default:
            break;
    }
}

- (void)helloWorldClicked {
//    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                        moduleName:@"HelloWorldCp"
//                                                 initialProperties:nil
//                                                     launchOptions:nil];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:_bridge
                                                     moduleName:@"HelloWorldCp"
                                              initialProperties:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)paramPassClicked {
    NSDictionary *param = @{@"scores" :@[
                                         @{@"name" : @"Alex",@"value": @"42"},
                                         @{@"name" : @"Joel",@"value": @"10"},
                                         @{@"name" : @"Zona",@"value": [NSString stringWithFormat:@"%ld",(long)_score]}
                                        ]
                            };
    
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"ParamPassCp"
                                                 initialProperties:param
                                                     launchOptions:nil];
    
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:_bridge
//                                                     moduleName:@"HelloWorldCp"
//                                              initialProperties:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    _rootView = rootView;
    [self tickTick];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)logClicked {
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNAlertCp"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)alertCallbackClicked {
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNIosCallbackCp"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)callRnClicked {
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"BeCalledCp"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- RCTBridgeDelegate

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
    return [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
}

#pragma mark -- time tick update js

- (void)tickTick {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(timerFire:)
                                            userInfo:nil
                                             repeats:YES];
}

-(void)timerFire:(id)userinfo {
    if (_rootView) {
        _rootView.appProperties = @{@"scores" :@[
                                            @{@"name" : @"Alex",@"value": @"42"},
                                            @{@"name" : @"Joel",@"value": @"10"},
                                            @{@"name" : @"Zona",@"value": [NSString stringWithFormat:@"%ld",(long)_score++]}
                                            ]
                                    };
    }
}

@end
