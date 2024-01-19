//
//  Place.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import "Place.h"
#import "PlacesList.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@implementation Place


//COSTRUTTORE DEL LUOGO
- (instancetype)initWithName:(NSString *)name
                     address:(NSString*)address
                 descriptionn:(NSString *)descriptionn
                   latitude:(double)latitude
                  longitude:(double)longitude
                   dateAdded:(NSString *)dateAdded {
    self = [super init];
    if (self) {
        _name = name;
        _address=address;
        _descriptionn = descriptionn;
        _latitude = latitude;
        _longitude = longitude;
        _dateAdded = dateAdded;
    }
    return self;
}






- (CLCircularRegion *)region {
    CLLocationCoordinate2D center = [self coordinate];
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:100.0 identifier:self.name];
    return region;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}





@end
