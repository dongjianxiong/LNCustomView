//
//  UIImageView+LNWebImage.h
//  LNScrollView
//
//  Created by dongjianxiong on 16/9/26.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LNWebImage)

- (void)ln_setImageWithUrlStr:(NSString *)urlString placeholder:(UIImage *)placeholder;

@end
