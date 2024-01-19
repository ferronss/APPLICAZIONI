// aggiungi nuovo luogo
//  NewplaceTableViewController.h
//  PlaceReminder
//
//  Created by Davide Ferroni on 15/11/23.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "PlacesList.h"
#import "PlacesData.h"
#import "PlaceDataProtocol.h"



NS_ASSUME_NONNULL_BEGIN

@interface NewplaceTableViewController : UITableViewController

@property (nonatomic, strong) PlacesList *placess;





@end

NS_ASSUME_NONNULL_END
