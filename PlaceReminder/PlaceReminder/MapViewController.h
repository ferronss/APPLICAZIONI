//mappa
//  MapViewController.h
//  PlaceReminder
//
//  Created by Davide Ferroni on 14/11/23.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>



NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController  <CLLocationManagerDelegate> 

@property (nonatomic) NSArray *places;

@property (nonatomic, strong) CLLocationManager *locationManager;





@end

NS_ASSUME_NONNULL_END
