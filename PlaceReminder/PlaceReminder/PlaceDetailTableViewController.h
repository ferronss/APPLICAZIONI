//dettagli di ogni luogo
//  PlaceDetailTableViewController.h
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "PlacesList.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlaceDetailTableViewController : UITableViewController

@property (nonatomic, strong) Place *thePlace;


@property (nonatomic, strong) PlacesList *luoghi;


@end

NS_ASSUME_NONNULL_END
