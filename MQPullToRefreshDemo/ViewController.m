//
//  ViewController.m
//  MQPullToRefreshDemo
//
//  Created by 马权 on 3/19/15.
//  Copyright (c) 2015 maquan. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+MQPullToRefresh.h"

@interface ViewController ()
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 700);
    
    [_scrollView addActionHandlerOnPullToRefreshView:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_scrollView.pullToRefreshView refreshDone];
        });
    } type:MQPullToRefreshTypeTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}
@end
