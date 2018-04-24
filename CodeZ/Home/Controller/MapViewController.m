//
//  MapViewController.m
//  CodeZ
//
//  Created by Primb_yqx on 2018/4/24.
//  Copyright © 2018年 HQExample. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *userLocation;
    MKMapView *map;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 视图控件 MKMapView，本身不提供定位导航功能，仅提供地图信息
    map = [[MKMapView alloc] init];
    [self.view addSubview:map];
    [map mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    // 跟踪用户位置
    map.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    map.showsUserLocation = YES;
    if (@available(iOS 11.0, *)) {
        [map registerClass:[MKAnnotationView class] forAnnotationViewWithReuseIdentifier:@"annotation"];
    }
    map.delegate = self;
    
    // 添加CoreLocation定位服务
    // 判断定位功能是否可用
    if ([CLLocationManager locationServicesEnabled]) {
        // 定位点
        userLocation = [[CLLocationManager alloc] init];
        userLocation.delegate = self;
        userLocation.distanceFilter = kCLLocationAccuracyHundredMeters; // 每隔多米刷新位置
//        [userLocation requestWhenInUseAuthorization];   // 使用定位授权
        [userLocation requestAlwaysAuthorization];  // 请求总是授权(前后台授权)
        [userLocation startUpdatingLocation];   // 开始定位
    }
}

- (void)getAddressInfo:(CLLocation *)location completion:(void(^)(CLPlacemark *))block{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                       CLPlacemark *place = (CLPlacemark *)[placemarks firstObject];
                       if (block) {
                           block(place);
                       }
                   }];
}

- (void)addAnnotation:(CLLocationCoordinate2D)location {
    //创建大头针
    CLLocation *loca = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    [self getAddressInfo:loca completion:^(CLPlacemark *place) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [map removeAnnotations:map.annotations];    // 待解决
            MKPointAnnotation *pointAnotiaon = nil;
            if (map.annotations.count == 1) {
                pointAnotiaon = [[MKPointAnnotation alloc] init];
                [map addAnnotation:pointAnotiaon];
            }else {
                pointAnotiaon = (MKPointAnnotation *)[map.annotations lastObject];
            }
            // 1：31.122239, 2：121.521260
            pointAnotiaon.coordinate = location;
            pointAnotiaon.title = place.name;
        });
    }];
}


#pragma mark - CLLocationManagerDelegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [userLocation startUpdatingLocation];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if(touch.phase == UITouchPhaseEnded) {
        if (touch.tapCount == 1) {
            // 开始选取定位点
            CGPoint position = [touch locationInView:map];
            CLLocationCoordinate2D touchLocation = [map convertPoint:position toCoordinateFromView:map];
            [self addAnnotation:touchLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *lastLocation = (CLLocation *)[locations lastObject];
    MKCoordinateSpan span = MKCoordinateSpanMake(1, 1);
    MKCoordinateRegion region = MKCoordinateRegionMake(lastLocation.coordinate, span);
    [map setRegion:region];
    // 停止定位
    [manager stopUpdatingLocation];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"%f, %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
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

@end
