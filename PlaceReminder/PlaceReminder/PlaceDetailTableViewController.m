//
//  PlaceDetailTableViewController.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import "PlaceDetailTableViewController.h"
#import "Place.h"
#import "PlacesList.h"
#import "PlacesData.h"
#import "PlacesListTableViewController.h"

@interface PlaceDetailTableViewController ()


@property (weak, nonatomic) IBOutlet UITextView *addresslabel;


@property (weak, nonatomic) IBOutlet UILabel *latitudelabel;


@property (weak, nonatomic) IBOutlet UILabel *longitudelabel;


@property (weak, nonatomic) IBOutlet UITextView *descriptionntext;



@property (weak, nonatomic) IBOutlet UILabel *datelabel;



@end

@implementation PlaceDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.thePlace.name;
    self.addresslabel.text=self.thePlace.address;
    self.latitudelabel.text = [NSString stringWithFormat:@"%f", self.thePlace.latitude];
    self.longitudelabel.text = [NSString stringWithFormat:@"%f", self.thePlace.longitude];
    self.descriptionntext.text = self.thePlace.descriptionn;
    self.datelabel.text= self.thePlace.dateAdded;

    
 
}

#pragma mark - Table view data source



//ELIMINA PLACE ALLA PRESSIONE
- (IBAction)Delete:(UIBarButtonItem *)sender {

[self.luoghi deleteobj:self.thePlace];
[self.navigationController popViewControllerAnimated:YES];

}


@end
