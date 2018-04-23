//
//  ScoketViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/23.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "ScoketViewController.h"
#import "ServerScoket.h"

@interface ScoketViewController () <GCDAsyncSocketDelegate>

@end

@implementation ScoketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ServerScoket sharedServerScoket];
    GCDAsyncSocket *clientScoket = [[GCDAsyncSocket alloc] init];
    NSError *error = nil;
    [clientScoket connectToHost:@"127.0.0.1" onPort:8080 error:&error];
    if (error) {
        NSAssert(error, @"Socket connected failed!");
    }else {
        clientScoket.delegate = self;
    }
    
    NSString *writeString = @"hello Server, this is client!";
    NSData *data = [writeString dataUsingEncoding:NSUTF8StringEncoding];
    [clientScoket writeData:data withTimeout:-1 tag:10];
    [clientScoket readDataWithTimeout:-1 tag:0];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹出框" message:@"action弹出框" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:submitAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark - GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"已经连接");
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"get message from server : %@", message);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
