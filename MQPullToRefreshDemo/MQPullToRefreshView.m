//
//  MQPullToRefreshView.m
//  MQPullToRefreshDemo
//
//  Created by 马权 on 3/19/15.
//  Copyright (c) 2015 maquan. All rights reserved.
//

#import "MQPullToRefreshView.h"

@interface MQPullToRefreshView ()

{
  @private
    UIScrollView *_scrollView;
    BOOL _show;
}

@end

@implementation MQPullToRefreshView

@synthesize show = _show;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _scrollView = scrollView;
        _triggerDistance = 60;
        _state = MQPullToRefreshStateRefreshDone;
    }
    return self;
}

- (void)refreshDone {
    self.state = MQPullToRefreshStateRefreshDone;
}

- (void)setShow:(BOOL)show {
    if (_show != show) {
        _show = show;
        if (_show) {
            [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [_scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [_scrollView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        }
        else {
            [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
            [_scrollView removeObserver:self forKeyPath:@"contentSize"];
            [_scrollView removeObserver:self forKeyPath:@"frame"];
        }
    }
}

- (BOOL)show {
    return _show;
}

- (void)setState:(MQPullToRefreshState)state {
    if (_state != state) {
        _state = state;
        switch (state) {
            case MQPullToRefreshStatePulling:
                NSLog(@"正在下拉");
                break;
            case MQPullToRefreshStateWillRefresh:
                NSLog(@"进入触发刷新区域");
                break;
            case MQPullToRefreshStateRefreshing:
        
                NSLog(@"正在刷新");
                _actionHandleBlock();
                break;
            case MQPullToRefreshStateRefreshDone:
                _scrollView.contentOffset = CGPointMake(0, -_triggerDistance);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (!_scrollView.dragging) {
                        _scrollView.contentOffset = CGPointMake(0, 0);
                    }
                });
                NSLog(@"刷新完毕");
                break;
            default:
                break;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
//        NSLog(@"  contentOffset = %@", NSStringFromCGPoint([[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]));
        [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    }
    if ([keyPath isEqualToString:@"contentSize"]) {
        NSLog(@"  contentSize = %@", NSStringFromCGSize([[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue]));
    }
    if ([keyPath isEqualToString:@"frame"]) {
        NSLog(@"  frame = %@", NSStringFromCGRect([[change valueForKey:NSKeyValueChangeNewKey] CGRectValue]));
    }
}

- (void)scrollViewDidScroll:(CGPoint)offset {
    
    CGFloat beyondDistance;
    if (_type == MQPullToRefreshTypeTop) {
        beyondDistance = ABS(offset.y);
//        NSLog(@"%f", beyondDistance);
        if (_state == MQPullToRefreshStateRefreshDone &&
            beyondDistance < _triggerDistance) {
            self.state = MQPullToRefreshStatePulling;
        }
        if (_state == MQPullToRefreshStatePulling &&
            beyondDistance < _triggerDistance) {
        }
        if (_state == MQPullToRefreshStatePulling &&
            beyondDistance > _triggerDistance &&
            _scrollView.dragging) {
            self.state = MQPullToRefreshStateWillRefresh;
        }
        if (_state == MQPullToRefreshStateWillRefresh &&
            !_scrollView.dragging) {
            self.state = MQPullToRefreshStateRefreshing;
        }
        if (_state == MQPullToRefreshStateWillRefresh &&
            beyondDistance < _triggerDistance &&
            _scrollView.dragging) {
            self.state = MQPullToRefreshStatePulling;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.type == MQPullToRefreshTypeTop) {
        self.frame = CGRectMake(0, -_triggerDistance, _scrollView.frame.size.width, _triggerDistance);
    }
}

@end
