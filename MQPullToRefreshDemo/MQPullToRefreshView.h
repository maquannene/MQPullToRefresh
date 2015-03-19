//
//  MQPullToRefreshView.h
//  MQPullToRefreshDemo
//
//  Created by 马权 on 3/19/15.
//  Copyright (c) 2015 maquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MQPullToRefreshState) {
    MQPullToRefreshStatePulling,                    //  pulling
    MQPullToRefreshStateWillRefresh,                //  will and can refresh
    MQPullToRefreshStateRefreshing,                 //  refreshing
    MQPullToRefreshStateRefreshDone                 //  refreshing done
};

typedef NS_ENUM(NSInteger, MQPullToRefreshType) {
    MQPullToRefreshTypeTop,
    MQPullToRefreshTypeBottom
};

typedef void (^ActionHandleBlock)(void);

@interface MQPullToRefreshView : UIView


@property (assign, nonatomic) MQPullToRefreshType type;                 //  top or bottom
@property (copy, nonatomic) ActionHandleBlock actionHandleBlock;
@property (assign, nonatomic) BOOL show;

@property (assign, nonatomic) MQPullToRefreshState state;               //  current view state
@property (assign, nonatomic) CGFloat triggerDistance;                  //  pull distance of trigger refresh. default: 60

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
- (void)refreshDone;

@end
