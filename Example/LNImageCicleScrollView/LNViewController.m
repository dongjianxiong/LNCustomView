//
//  LNViewController.m
//  LNImageCicleScrollView
//
//  Created by DONGJIANXIONG1 on 05/21/2020.
//  Copyright (c) 2020 DONGJIANXIONG1. All rights reserved.
//

#import "LNViewController.h"
#import "LNImageCircleScrollView.h"
#import "UIImageView+LNWebImage.h"

@interface LNViewController ()

@end


@interface LNViewController ()<LNImageCircleScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageUrlArr;

@property (nonatomic, strong) LNImageCircleScrollView *scrollView;

@end

@implementation LNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片url
    self.imageUrlArr = [NSArray arrayWithObjects:@"http://c.hiphotos.baidu.com/image/h%3D200/sign=7079be42532c11dfc1d1b82353266255/342ac65c10385343e952fe809713b07ecb8088f5.jpg",@"http://e.hiphotos.baidu.com/image/h%3D200/sign=5f5941a28344ebf87271633fe9f8d736/2e2eb9389b504fc2e15bc8a4e1dde71190ef6d0e.jpg",@"http://b.hiphotos.baidu.com/image/h%3D200/sign=9b711189efc4b7452b94b016fffd1e78/3c6d55fbb2fb4316fc06edda24a4462309f7d371.jpg",@"http://h.hiphotos.baidu.com/image/h%3D200/sign=fc55a740f303918fc8d13aca613c264b/9213b07eca80653893a554b393dda144ac3482c7.jpg",@"http://g.hiphotos.baidu.com/image/h%3D200/sign=dccb079f4ffbfbedc359317f48f1f78e/8b13632762d0f70317eb037c0cfa513d2697c531.jpg", nil];
    
    CGRect scrollViewFrame = CGRectMake(10, 200, self.view.frame.size.width-20, self.view.frame.size.height-200 - 50);
        
    
    //创建滚动视图
    LNImageCircleScrollView *scrollView = [[LNImageCircleScrollView alloc] initWithFrame:scrollViewFrame];
    scrollView.circleDelegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    //设置图片页数
    [self.view addSubview:scrollView];
    
    [scrollView reloadImages];
    
    self.scrollView = scrollView;
//    [scrollView timerSart:3];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView timerSart:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LNImageCircleScrollViewDelegate
- (NSInteger)numberOfImage:(LNImageCircleScrollView *)scrollView
{
    return self.imageUrlArr.count;
}

- (void)circleScrollView:(LNImageCircleScrollView *)scrollView imageView:(UIImageView *)imageView atIndex:(NSInteger)index
{
    UIImage *placeholder = [UIImage imageNamed:@"1.png"];
    [imageView ln_setImageWithUrlStr:self.imageUrlArr[index] placeholder:placeholder];
}

- (UIEdgeInsets)circleScrollViewImageInset:(LNImageCircleScrollView *)scrollView
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)circleScrollView:(LNImageCircleScrollView *)scrollView didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"Tap at %ld", (long)index);
}

@end

