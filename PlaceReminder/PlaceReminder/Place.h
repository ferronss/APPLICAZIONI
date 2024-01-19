//classe dei posti
//  Place.h
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Place : NSObject


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic,readonly) double latitude;
@property (nonatomic,readonly) double longitude;
@property (nonatomic, strong) NSString *descriptionn;
@property (nonatomic, strong) NSString *dateAdded;

- (instancetype)initWithName:(NSString *)name
                     address:(NSString*)address
                 descriptionn:(NSString *)descriptionn
                   latitude:(double)latitude
                  longitude:(double)longitude
                   dateAdded:(NSString *)dateAdded;



- (CLCircularRegion *)region;




@end

NS_ASSUME_NONNULL_END
