//
//  PlacesList.h
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import <Foundation/Foundation.h>
#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlacesList : NSObject

- (long)size;
- (NSArray *)getAll;
- (void)add:(Place *)f;
- (Place *)getAtIndex:(NSInteger)index;
- (void) deleteobj:(Place *)f;

@end

NS_ASSUME_NONNULL_END
