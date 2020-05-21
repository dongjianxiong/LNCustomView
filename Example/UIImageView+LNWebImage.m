//
//  UIImageView+DJXWebImage.m
//  DJXScrollView
//
//  Created by dongjianxiong on 16/9/26.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import "UIImageView+LNWebImage.h"



@implementation UIImageView (LNWebImage)

+ (NSCache *)djx_ImageCache
{
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!cache) {
            cache = [[NSCache alloc] init];
        }
    });
    return cache;
}

- (void)ln_setImageWithUrlStr:(NSString *)urlString placeholder:(UIImage *)placeholder
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if ([[UIImageView djx_ImageCache] objectForKey:urlString]) {
        self.image = [[UIImageView djx_ImageCache] objectForKey:urlString];
    }else{
        self.image = placeholder;
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                self.image = [UIImage imageWithData:data];
                if (self.image) {
                    [[UIImageView djx_ImageCache] setObject:self.image forKey:urlString];
                }
            }
        });
    }];

}

@end
