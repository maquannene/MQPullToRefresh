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
        _state = MQPullToRefreshStateNormal;
    }
    return self;
}

- (void)refreshDone {
    self.state = MQPullToRefreshStateNormal;
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
            case MQPullToRefreshStateNormal:
                NSLog(@"回复正常状态");
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                                 animations:^{
                                     _scrollView.contentInset = UIEdgeInsetsZero;
                                 }
                                 completion:NULL];
                break;
            case MQPullToRefreshStateWillRefresh:
                NSLog(@"进入触发刷新区域");
                break;
            case MQPullToRefreshStateRefreshing:
        
                NSLog(@"正在刷新");
                _actionHandleBlock();
                break;
            default:
                break;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
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
        //  当前在刷新
        if (_state == MQPullToRefreshStateRefreshing) {
            CGFloat offsetY;
            offsetY = MIN(beyondDistance, _triggerDistance);
            _scrollView.contentInset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        }
        else {
            if (_state == MQPullToRefreshStateWillRefresh &&
                !_scrollView.dragging) {
                self.state = MQPullToRefreshStateRefreshing;        //  刷新
            }
            else if (_state == MQPullToRefreshStateNormal &&
                     beyondDistance > _triggerDistance &&
                     _scrollView.dragging) {
                self.state = MQPullToRefreshStateWillRefresh;       //  将刷新
            }
            else if(_state != MQPullToRefreshStateNormal &&
                    beyondDistance < _triggerDistance) {
                self.state = MQPullToRefreshStateNormal;            //  正常
            }
        }
        
    }
    else {
    
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.type == MQPullToRefreshTypeTop) {
        self.frame = CGRectMake(0, -_triggerDistance, _scrollView.frame.size.width, _triggerDistance);
    }
    else {
    
    }
}

@end
