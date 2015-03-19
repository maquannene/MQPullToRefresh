//
//  UIScrollView+MQPullToRefresh.h
//  MQPullToRefreshDemo
//
//  Created by 马权 on 3/19/15.
//  Copyright (c) 2015 maquan. All rights reserved.
//

/*
    MQPullToRefreshView *pullToRefreshView; 提供给外界，进行自定义设置
    BOOL showPullToRefreshView;             是否开启刷新界面
 
    //  一个方法添加刷新handle
    - (void)addActionHandlerOnPullToRefreshView:(void (^) (void))actionHandler
                                           type:(MQPullToRefreshType)type;
 */

#import <UIKit/UIKit.h>
#import "MQPullToRefreshView.h"

@class MQPullToRefreshView;

@interface UIScrollView (MQPullToRefresh)

@property (retain, nonatomic, readonly) MQPullToRefreshView *pullToRefreshView;
@property (assign, nonatomic) BOOL showPullToRefreshView;

- (void)addActionHandlerOnPullToRefreshView:(void (^) (void))actionHandler
                                       type:(MQPullToRefreshType)type;

@end
