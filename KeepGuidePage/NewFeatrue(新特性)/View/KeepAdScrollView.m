//
//  KeepAdScrollView.m
//  KeepGuidePage
//
//  Created by Michael on 16/6/30.
//  Copyright © 2016年 com.51fanxing.KeepGuidePage. All rights reserved.
//

#import "KeepAdScrollView.h"
#import "KeepAdLabel.h"

@interface KeepAdScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@end
@implementation KeepAdScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.scrollsToTop = NO;
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    [self setbanner];
}

- (void)setbanner
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = 30;
    CGFloat Y = self.bounds.size.height - H;

    KeepAdLabel *lastLabel = [[KeepAdLabel alloc] init];
    
    KeepAdLabel *firstLabel = [[KeepAdLabel alloc] init];
    
    for (int i = 0; i < self.titles.count; i++) {
        
        KeepAdLabel *advertLabel = [[KeepAdLabel alloc] init];
        
        CGFloat X = i * W + W;
        advertLabel.frame = CGRectMake(X , Y, W, H);
        advertLabel.text = self.titles[i];
  
        if (i == 0) {
            firstLabel.text = self.titles[i];
        }
        if (i == self.titles.count - 1) {
            lastLabel.text = self.titles[i];
        }
        [self addSubview:advertLabel];
    }
    
    lastLabel.frame = CGRectMake(0, Y, W, H);
    [self addSubview:lastLabel];
    
    firstLabel.frame = CGRectMake((self.titles.count + 1) * W, Y, W, H);
    [self addSubview:firstLabel];

    CGFloat contentW = (self.titles.count + 2) * W;
    self.contentSize = CGSizeMake(contentW, 0);

    self.showsHorizontalScrollIndicator = NO;
    
    self.pagingEnabled = YES;
    
    [self setContentOffset:CGPointMake(W, 0)];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidStop:(UIScrollView *)scrollView
{
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width;
    int page = (self.contentOffset.x + 0.5 * scrollW) / scrollW;
    if (page == 0){
        [self setContentOffset:CGPointMake(scrollW * self.titles.count, 0)];
    } else if (page == (self.titles.count + 1)) {
        [self setContentOffset:CGPointMake(scrollW , 0)];
    }
}


@end
