//
//  XYSocketManager.h
//  XYSocketTest
//
//  Created by Xue Yang on 2017/3/9.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSocketManager : NSObject
+ (instancetype)instance;

- (BOOL)connect;
- (void)disconnect;

- (void)sendMsg:(NSString *)msg;

@end
