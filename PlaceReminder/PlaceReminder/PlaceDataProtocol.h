//
//  PlaceDataProtocol.h
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import <Foundation/Foundation.h>
#import "PlacesList.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PlaceDataProtocol <NSObject>


-(PlacesList *) getPlaces;


@end

NS_ASSUME_NONNULL_END
