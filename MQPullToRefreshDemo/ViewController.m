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
            [_scrollView.pullToRefreshView refreshSucceed:YES duration:2];
        });
    } type:MQPullToRefreshTypeTop];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
    label1.backgroundColor = [UIColor whiteColor];
    label1.text = @"pull refresh";
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
    label2.backgroundColor = [UIColor whiteColor];
    label2.text = @"release refresh";
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
    label3.backgroundColor = [UIColor whiteColor];
    label3.text = @"refreshing";
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
    label4.backgroundColor = [UIColor whiteColor];
    label4.text = @"refresh succeed";
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
    label5.backgroundColor = [UIColor whiteColor];
    label5.text = @"refresh failed";
    [self.scrollView.pullToRefreshView customRefreshView:label1 forState:MQPullToRefreshStateNormal];
    [self.scrollView.pullToRefreshView customRefreshView:label2 forState:MQPullToRefreshStateWillRefresh];
    [self.scrollView.pullToRefreshView customRefreshView:label3 forState:MQPullToRefreshStateRefreshing];
    [self.scrollView.pullToRefreshView customRefreshView:label4 forState:MQPullToRefreshStateRefreshSucceed];
    [self.scrollView.pullToRefreshView customRefreshView:label5 forState:MQPullToRefreshStateRefreshFailed];
    [label1 release];
    [label2 release];
    [label3 release];
    [label4 release];
    [label5 release];
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
