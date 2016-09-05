//
//  EGRootViewController.m
//  MealRecord
//
//  Created by 周文杰 on 16/9/3.
//  Copyright © 2016年 com.ergou. All rights reserved.
//

#import "EGRootViewController.h"
#import "EGMapViewController.h"
#import "EGListViewController.h"

@interface EGRootViewController (){
    UISegmentedControl *_segement;
}

@property (nonatomic,strong)EGMapViewController *mapVC;
@property (nonatomic,strong)EGListViewController *listVC;

@end

@implementation EGRootViewController

- (id)init{
    self = [super init];
    if (self) {
        _mapVC = [[EGMapViewController alloc] init];
        _listVC = [[EGListViewController alloc] init];
        [self addChildViewController:_mapVC];
        [self addChildViewController:_listVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _segement = [[UISegmentedControl alloc] initWithItems:@[@"地图",@"列表"]];
    [_segement addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    self.navigationItem.titleView = _segement;
    [_segement setSelectedSegmentIndex:0];
    [self.view addSubview:_mapVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)segmentAction:(id)sender{
    
    NSInteger selected = _segement.selectedSegmentIndex;
    
}

@end
