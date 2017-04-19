//
//  ViewController.m
//  XYSocketTest
//
//  Created by Xue Yang on 2017/3/9.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import "ViewController.h"
#import "XYSocketManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}
- (IBAction)send {
    if (_tf.text.length == 0) return;
    [[XYSocketManager instance] sendMsg:_tf.text];
}
- (IBAction)connect {
    if ([[XYSocketManager instance] connect]) {
        NSLog(@"连接成功");
    }
}
- (IBAction)disconnect {
    
}

@end
