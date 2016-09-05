//
//  ViewController.m
//  MealRecord
//
//  Created by 周文杰 on 16/9/3.
//  Copyright © 2016年 com.ergou. All rights reserved.
//

#import "EGMapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "EGEditViewController.h"

@interface EGMapViewController ()

@property(nonatomic,strong)BMKMapView *mapView ;

@end

@implementation EGMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES ;
    self.mapView.zoomLevel = 16 ;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
//    UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addTag:)];
//    [self.mapView addGestureRecognizer:ges];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<BMKAnnotation>)addPointAnnotation:(CLLocationCoordinate2D) location{
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];

    annotation.coordinate = location;
    annotation.title = @" ";
    [_mapView addAnnotation:annotation];
    return annotation;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate

{
    
    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    CLLocationCoordinate2D location;
    location.latitude=coordinate.latitude;
    location.longitude=coordinate.longitude;
    //    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,(int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    id <BMKAnnotation>anno = [self addPointAnnotation:location];
    //
    [self editAnnotation:anno];
}

- (void)editAnnotation:(id <BMKAnnotation>)anno{
    EGEditViewController *vc = [[EGEditViewController alloc] init];
    vc.onFinish = ^(NSString *day,NSString *restaurant){
        ((BMKPointAnnotation*)anno).title = [NSString stringWithFormat:@"%@ %@",day,restaurant];
        [self saveTag:anno];
    };
    [self.navigationController pushViewController:vc animated:YES ];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
}
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view1{
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [mapView deselectAnnotation:view1.annotation animated:YES];
    }];
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [mapView deselectAnnotation:view1.annotation animated:YES];
        [self editAnnotation:view1.annotation];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [view1 removeFromSuperview];
        [mapView deselectAnnotation:view1.annotation animated:YES];
    }];
    [sheet addAction:editAction];
    [sheet addAction:deleteAction];
    [sheet addAction:cancelAction];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)saveTag:(id<BMKAnnotation>)anno{
    
}

@end
