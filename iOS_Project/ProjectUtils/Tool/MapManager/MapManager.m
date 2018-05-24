
//
//  MapManager.m
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/20.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import "MapManager.h"

#import <CoreLocation/CoreLocation.h>

@interface MapManager () <CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;   //定位服务管理类
    LocationBlock _locationCompleteBlk;
    BOOL _deferringUpdates;  //标记是否是Defer
}

@end


@implementation MapManager

static MapManager* _mapManager = nil;

+ (instancetype)shareMapManager
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _mapManager = [[super allocWithZone:NULL] init] ;
        
    }) ;
    return _mapManager ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [MapManager shareMapManager] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [MapManager shareMapManager] ;
}

- (void)initLoacation {
    _locationManager = [[CLLocationManager alloc] init];     //创建CLLocationManager对象
    _locationManager.delegate = self;                        //设置代理，这样函数didUpdateLocations才会被回调
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设置定位精度
    _locationManager.distanceFilter = kCLErrorDeferredDistanceFiltered;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [_locationManager requestWhenInUseAuthorization];
    }
    if(![CLLocationManager locationServicesEnabled]){
        NSLog(@"请开启定位:设置 > 隐私 > 位置 > 定位服务");
    }
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        //        [_locationManager requestAlwaysAuthorization]; // 永久授权
        [_locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    
    //    if ([_locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)]) {
    //        [_locationManager setAllowsBackgroundLocationUpdates:YES];
    //    }
    _locationManager.pausesLocationUpdatesAutomatically = NO;
}

- (void)startLocationWithComplete:(LocationBlock)locationComplete {
    [self initLoacation];
    [_locationManager startUpdatingLocation];
    _locationCompleteBlk = locationComplete;
}


#pragma mark-CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{  //定位服务回调函数
    
    CLLocation *location = [locations lastObject];    //当前位置信息
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
           
            
         
            MapManagerModel *locationModel = [[MapManagerModel alloc] init];
            locationModel.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            locationModel.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            locationModel.detailaddr = placemark.addressDictionary[@"FormattedAddressLines"];
            locationModel.city=city;
            locationModel.province=[placemark.addressDictionary objectForKey:@"State"];
             locationModel.SubLocality=[placemark.addressDictionary objectForKey:@"SubLocality"];
            
            NSLog(@"定位城市：%@%@%@", locationModel.province,locationModel.city,locationModel.SubLocality);
            
            
            if (_locationCompleteBlk) {
                _locationCompleteBlk(locationModel);
            }
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
            
        }
    }];
    
    [NSUserDefaultTools setStringValueWithKey:@"1" key:@"IsAllowLocation"];
  
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    //
    //    if (!_deferringUpdates) {
    //        CLLocationDistance distance = 500;
    //        NSTimeInterval time = 3600;
    //        [_locationManager allowDeferredLocationUpdatesUntilTraveled:distance
    //                                                           timeout:time];
    //        _deferringUpdates = YES;
    //    }
    
    [manager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(nullable NSError *)error {
    _deferringUpdates = NO;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        [NSUserDefaultTools setStringValueWithKey:@"0" key:@"IsAllowLocation"];
    
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
@end
