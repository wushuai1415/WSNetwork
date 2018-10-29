//
//  WSViewController.m
//  WSNetwork
//
//  Created by ws on 10/24/2018.
//  Copyright (c) 2018 ws. All rights reserved.
//

#import "WSViewController.h"
#import <WSNetwork/WSNetwork.h>
#import "WSTestDataManager.h"

@interface WSViewController () <WSServiceFactoryDataSource, WSNetManagerInterceptor>

@property (nonatomic, strong) WSTestDataManager *testDataManager;

@end

@implementation WSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [WSServiceFactory sharedInstance].dataSource = self;
    
    [self.testDataManager loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WSServiceFactoryDataSource

- (NSDictionary<NSString *,NSString *> *)servicesKindsOfServiceFactory {
    return @{@"DefaultService":@"WSDefaultService"};
}

#pragma mark - WSNetManagerInterceptor

- (void)beforeCallRequest:(WSBaseNetworkManager *)manager {
    NSLog(@"-------------------before");
}

- (void)afterCallRequest:(WSBaseNetworkManager *)manager {
    NSLog(@"-------------------after");
    NSLog(@"%@", manager.responseData);
}

#pragma mark - getter

- (WSTestDataManager *)testDataManager {
    if (!_testDataManager) {
        _testDataManager = [WSTestDataManager new];
        _testDataManager.interceptor = self;
    }
    return _testDataManager;
}

@end
