//
//  XYSocketManager.m
//  XYSocketTest
//
//  Created by Xue Yang on 2017/3/9.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import "XYSocketManager.h"
#import "GCDAsyncSocket.h"
@interface XYSocketManager()<GCDAsyncSocketDelegate>

@end
@implementation XYSocketManager
{
    GCDAsyncSocket *_asynSocket;
}

+ (instancetype)instance
{
    static dispatch_once_t onceToken;
    static  XYSocketManager *socketMrg = nil;
    dispatch_once(&onceToken, ^{
        socketMrg = [[self alloc] init];
        [socketMrg initSocket];
    });
    return socketMrg;
}

- (void)initSocket
{
    //1.初始化GCDAsyncSocket 并设置 代理 与 代理线程
    _asynSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}

//建立连接
- (BOOL)connect
{
    //2. 连接服务器
   return [_asynSocket connectToHost:@"127.0.01" onPort:6969 error:nil];
}
//断开连接
- (void)disconnect
{
    [_asynSocket disconnect];
}

- (void)sendMsg:(NSString *)msg
{
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    //写入数据（发送数据给服务器） -1为不超时
    [_asynSocket writeData:data withTimeout:-1 tag:110];
}

//3.代理回调
#pragma mark --- GCDAsyncSocketDelegate
//连接服务器成功时，回调
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"host = %@,port = %d",host,port);
    
    //接收
    [_asynSocket readDataWithTimeout:-1 tag:110];
}
//断开连接或连接失败时回调。此方法内写心跳
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{

}
//服务器接收到客户端写入的数据后 回调
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"服务器接收到数据 tag= %ld",tag);
    
    //接收
    [_asynSocket readDataWithTimeout:-1 tag:110];
    
}
//收到服务端发来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到服务端发来的数据 %@",str);
}
@end
