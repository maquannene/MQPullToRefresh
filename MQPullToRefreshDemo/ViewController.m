//
//  ViewController.m
//  MQPullToRefreshDemo
//
//  Created by 马权 on 3/19/15.
//  Copyright (c) 2015 maquan. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+MQPullToRefresh.h"

@interface ViewController () <MQPullToRefreshViewDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 700);
    
    //  3 step use pull refresh
    
    //  1.  open refresh
    _scrollView.showPullToRefreshView = YES;
    _scrollView.pullToRefreshView.delegate = self;
    
    //  2.  custom refresh view
    //  MQPullToRefreshStateNormal
    //  MQPullToRefreshStateWillRefresh
    //  MQPullToRefreshStateRefreshing
    //  MQPullToRefreshStateRefreshSucceed          not necessary
    //  MQPullToRefreshStateRefreshFailed           not necessary
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 33)];
    label1.backgroundColor = [UIColor whiteColor];
    label1.text = @"pull refresh";
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 33)];
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
    
    //  3.  bash config
    [_scrollView addActionHandlerOnPullToRefreshView:MQPullToRefreshTypeTop
                                     triggerDistance:33
                                 requestRefreshBlock:^
    {
        NSLog(@"let go and request refresh");
        //  assuming refresh succeed 2 second after
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"refresh success");
            [_scrollView.pullToRefreshView refreshSucceed:YES duration:2];
        });
    }];
}

- (void)pullToRefreshView:(MQPullToRefreshView *)refreshView willChangeState:(MQPullToRefreshState)state {
    switch (state) {
        case MQPullToRefreshStateNormal:
            NSLog(@"MQPullToRefreshStateNormal - recover to normal");
            break;
        case MQPullToRefreshStateWillRefresh:
            NSLog(@"MQPullToRefreshStateWillRefresh - enter refresh area");
            break;
        case MQPullToRefreshStateRefreshing:
            NSLog(@"MQPullToRefreshStateRefreshing - is refreshing now");
            break;
        case MQPullToRefreshStateRefreshFailed:
            NSLog(@"MQPullToRefreshStateRefreshing - refresh failed");
            break;
        case MQPullToRefreshStateRefreshSucceed:
            NSLog(@"MQPullToRefreshStateRefreshing - frefresh succced");
            break;
            
        default:
            break;
    }
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
