//
//  DJXScrollView.h
//  DJXScrollView
//
//  Created by dongjianxiong on 16/9/26.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

//#import <UIKit/UIKit.h>
//
//@class LNImageCircleScrollView;
//
//@protocol LNImageCircleScrollViewDelegate <NSObject>
//
//- (NSInteger)numberOfImage:(LNImageCircleScrollView *)scrollView;
//- (void)circleScrollView:(LNImageCircleScrollView *)scrollView imageView:(UIImageView *)imageView atIndex:(NSInteger)index;
//- (UIEdgeInsets)circleScrollViewImageInset:(LNImageCircleScrollView *)scrollView;
//- (void)circleScrollView:(LNImageCircleScrollView *)scrollView didSelectedAtIndex:(NSInteger)index;
//
//@end
//
//@interface LNImageCircleScrollView : UIScrollView
//
//@property (nonatomic, weak) id<LNImageCircleScrollViewDelegate> circleDelegate;
//
////重载图片
//- (void)reloadImages;
//
////开启定时器滚动，默认不开启
//- (void)timerSart:(NSTimeInterval)interval;
//
////是否显示分页，默认显示
//- (void)hiddenPage:(BOOL)isHidden;
//
//@end


#import <UIKit/UIKit.h>

@class LNImageCircleScrollView;

@protocol LNImageCircleScrollViewDelegate <NSObject>

- (NSInteger)numberOfImage:(LNImageCircleScrollView *_Nullable)scrollView;
- (void)circleScrollView:(LNImageCircleScrollView *_Nullable)scrollView imageView:(UIImageView *_Nullable)imageView atIndex:(NSInteger)index;
- (UIEdgeInsets)circleScrollViewImageInset:(LNImageCircleScrollView *_Nullable)scrollView;
- (void)circleScrollView:(LNImageCircleScrollView *_Nullable)scrollView didSelectedAtIndex:(NSInteger)index;

@end

@interface LNImageCircleScrollView : UIScrollView

@property (nonatomic, weak) id<LNImageCircleScrollViewDelegate> _Nullable circleDelegate;

//重载图片
- (void)reloadImages;

//开启定时器滚动，默认不开启
- (void)timerSart:(NSTimeInterval)interval;

//是否显示分页，默认显示
- (void)hiddenPage:(BOOL)isHidden;

@end

