//tabella luoghi
//  PlacesListTableViewController.h
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import <UIKit/UIKit.h>
#import "PlaceDataProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlacesListTableViewController : UITableViewController


@property (nonatomic,strong) id<PlaceDataProtocol> dataSource;
@property (nonatomic, strong) NSString *dati;


@end

NS_ASSUME_NONNULL_END
