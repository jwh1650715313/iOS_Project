//          | INRI |
//          |      |
//          |      |
// .========'      '========.
// |   _      xxxx      _   |
// |  /_;-.__ / _\  _.-;_\  |
// |     `-._`'`_/'`.-'     |
// '========.`\   /`========'
//          | |  / |
//          |/-.(  |               // MARK: 页面功能：选取工具
//          |\_._\ |
//          | \ \`;|               Created by Ghost on 2016.
//          |  > |/|
//          | / // |        Copyright © 2016年 Ghost. All rights reserved.
//          | |//  |
//          | \(\  |
//          |  ``  |
//          |      |
//          |      |
//          |      |
//          |______|
//
// ^ `^`^ ^`` `^ ^` ``^^`  `^^` `^ `^ ^ `^`^ ^`` `^ ^` ``^^`  `^^` `^ `^

#import <UIKit/UIKit.h>

typedef void(^FinishBlock)(NSInteger index, NSString *title);

@interface PickerTool : UIView

@property (strong, nonatomic) NSArray *dataSource;
@property (copy, nonatomic) FinishBlock finishCallBack;

- (void)show;

@end
