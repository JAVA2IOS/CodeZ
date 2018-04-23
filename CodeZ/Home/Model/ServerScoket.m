//
//  ServerScoket.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/23.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "ServerScoket.h"
@interface ServerScoket()<GCDAsyncSocketDelegate> {
    GCDAsyncSocket *serverSocket;
}
@end

@implementation ServerScoket

+ (instancetype)sharedServerScoket {
    static ServerScoket *server = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        server = [[ServerScoket alloc] init];
        [server p_initServerSocket];
    });
    return server;
}

- (void)p_initServerSocket {
    serverSocket = [[GCDAsyncSocket alloc] init];
    serverSocket.delegate = self;
    [serverSocket acceptOnPort:8080 error:nil];
}

- (NSData *)p_writeData {
    NSData *writedData = [[NSData alloc] init];
    NSString *writeString = @"this message from Server: hello client!";
    writedData = [writeString dataUsingEncoding:NSUTF8StringEncoding];
    return writedData;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"server  connected");
    NSData *data = [self p_writeData];
    [serverSocket writeData:data withTimeout:-1 tag:10];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
}

@end
