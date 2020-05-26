//
//  DJXCircleScrollView.m
//  DJXCircleScrollView
//
//  Created by dongjianxiong on 16/9/26.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//


#import "LNImageCircleScrollView.h"

@interface LNImageCircleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

/**
 * 子视图数组
 */
@property (nonatomic, strong) NSMutableArray *containerViews;

/**
 * 图片视图数组
 */
@property (nonatomic, strong) NSMutableArray *imageViews;

/**
 * 当前页
 */
@property (nonatomic, assign) NSInteger currentPageIndex;

/**
 * 显示分页标记
 */
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) BOOL isScrollRight;

@property (nonatomic, assign) NSTimeInterval timerInterval;

@end

@implementation LNImageCircleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];

        self.containerViews = [NSMutableArray array];
        self.imageViews = [NSMutableArray array];

        for (int index = 0; index < 3; index ++) {//创建三个imageView用于循环显示图片
            
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake((index) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [self.scrollView addSubview:containerView];
            [self.containerViews addObject:containerView];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:containerView.bounds];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            [containerView addSubview:imageView];
            [self.imageViews addObject:imageView];
        }

        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
          self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
          self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
          self.pageControl.currentPage = 0;
          [self addSubview:self.pageControl];
    }
    return self;
}

- (void)timerSart:(NSTimeInterval)interval
{
    self.isScrollRight = YES;
    if (interval <= 0) {
        interval = 1;
    }
    self.timerInterval = interval;

    [self starTimer];
}


- (void)hiddenPage:(BOOL)isHidden;
{
    self.pageControl.hidden = isHidden;
}

- (void)setPageControllCenter:(CGPoint)center
{
    self.pageControl.center = center;
}

- (void)starTimer
{

    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), (uint64_t)(self.timerInterval*NSEC_PER_SEC), 0);

    dispatch_source_set_event_handler(self.timer, ^{
        if (self.isScrollRight) {
            [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0.0f) animated:true];
        }else{
            [self.scrollView setContentOffset:CGPointMake(0, 0.0f) animated:true];
        }
    });
    dispatch_resume(self.timer);
}

- (void)cancelTimer
{
    if (_timer != nil) {
        dispatch_source_cancel(_timer);
    }
}

- (void)dealloc
{
    [self cancelTimer];
}

- (void)reloadImages
{
    [self checkTotalCount:[self.circleDelegate numberOfImage:self]];
}

- (void)checkTotalCount:(NSInteger)totalCount
{
    if (totalCount <= 0) {
        return;
    }
    if (totalCount == 1) {//当只有一张图片的时候不滚动
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.scrollView.scrollEnabled = NO;
    }else{
        //当图片数大于一张时可以滚动
        self.scrollView.contentSize = CGSizeMake(3*CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        self.scrollView.scrollEnabled = YES;
    }
    [self resetImageViews];
    self.pageControl.numberOfPages = totalCount;
}

//当视图滚动的时候
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= (CGRectGetWidth(scrollView.frame) * 2)) {
        self.isScrollRight = YES;
        self.currentPageIndex = [self validNextPageWithExpectedNextPage:self.currentPageIndex+1];
        [self resetImageViews];
    }else if(scrollView.contentOffset.x <=0) {
        self.isScrollRight = NO;
        self.currentPageIndex = [self validNextPageWithExpectedNextPage:self.currentPageIndex-1];
        [self resetImageViews];
    }
    self.pageControl.currentPage = self.currentPageIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self cancelTimer];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self performSelector:@selector(starTimer) withObject:nil afterDelay:5];
}

//
- (void)resetImageViews
{
    NSInteger totalCount = [self.circleDelegate numberOfImage:self];

    if (totalCount == 1) {
        //如果只有一张图片，不需要滚动
        [self.circleDelegate circleScrollView:self imageView:self.imageViews[1] atIndex:self.currentPageIndex];
    }else if (totalCount > 1){

        //获取子视图
        [self getContentViewsWithLocations];

        //视图布局完之后返回到中间的位置
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0.0f) animated:NO];

    }else{
        NSLog(@"There is no subviews to show");
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.circleDelegate) {
        [self.circleDelegate circleScrollView:self didSelectedAtIndex:self.currentPageIndex];
    }
}

//获取子视图
- (void)getContentViewsWithLocations
{
    NSInteger leftPage = [self validNextPageWithExpectedNextPage:self.currentPageIndex-1];
    //获取将要在左边显示的视图
    [self imageAtIndex:leftPage location:0];

    NSInteger currentPage = self.currentPageIndex;
    //获取将要在中间显示的视图
    [self imageAtIndex:currentPage location:1];

    NSInteger rightPage = [self validNextPageWithExpectedNextPage:self.currentPageIndex+1];
    [self imageAtIndex:rightPage location:2];
    //获取将要在右边显示的视图

}

- (void)imageAtIndex:(NSInteger)index
          location:(NSInteger)location
{

    UIEdgeInsets edgeInsets = [self.circleDelegate circleScrollViewImageInset:self];
    //重新对子视图进行布局
    UIImageView *imageView = self.imageViews[location];
    CGFloat imageWidth = self.frame.size.width - edgeInsets.left - edgeInsets.right;
    CGFloat imageHeight = self.frame.size.height - edgeInsets.top - edgeInsets.bottom;
    imageView.frame = CGRectMake(edgeInsets.left, edgeInsets.top, imageWidth, imageHeight);
    [self.circleDelegate circleScrollView:self imageView:imageView atIndex:index];
}

//获取有效下一页
- (NSInteger)validNextPageWithExpectedNextPage:(NSInteger)expectedNextPage
{
    NSInteger totalCount = [self.circleDelegate numberOfImage:self];
    if (expectedNextPage == -1) {
        return totalCount - 1;
    }else if (expectedNextPage == totalCount || expectedNextPage < -1){
        return 0;
    }else if (expectedNextPage > totalCount){
        return totalCount - 1;
    }else{
        return expectedNextPage;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
