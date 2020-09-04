//
//  WHSchemeHandler.h
//  iOS_Project
//
//  Created by 景文浩 on 2020/9/4.
//  Copyright © 2020 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHSchemeHandler : NSObject

// currentHandler
+ (WHSchemeHandler *)currentHandler;

// handle url
- (void)handleUrl:(NSString *)url animated:(BOOL)animated;


@end


NS_ASSUME_NONNULL_END
