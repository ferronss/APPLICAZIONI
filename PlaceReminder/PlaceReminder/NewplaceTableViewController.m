//
//  NewplaceTableViewController.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 15/11/23.
//

#import "NewplaceTableViewController.h"
#import "Place.h"
#import "PlacesList.h"
#import "PlacesData.h"
#import "PlaceDataProtocol.h"
#import "PlacesListTableViewController.h"
#import <CoreLocation/CoreLocation.h>




@interface NewplaceTableViewController ()





@property (strong, nonatomic) IBOutlet UITextField *NameTextField;


@property (strong, nonatomic) IBOutlet UITextField *AdressTextField;



@property (strong, nonatomic) IBOutlet UITextField *LatitudeTextField;



@property (strong, nonatomic) IBOutlet UITextField *LongitudeTextField;


@property (strong, nonatomic) IBOutlet UITextView *DescriptionTextField;






@end

@implementation NewplaceTableViewController
- (IBAction)SaveButoonPressed:(UIBarButtonItem *)sender {
    

    NSTimeZone *romeTimeZone = [NSTimeZone timeZoneWithName:@"Europe/Rome"];

    // Crea  NSDate con  orario di Roma
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:romeTimeZone];

    // Imposta il formato
    [dateFormatter setDateFormat:@"yyyy-MM-dd      HH:mm:ss"];

    //  stringa formattata senza fuso orario
    NSString *formattedDate = [dateFormatter stringFromDate:currentDate];
    NSLog(@"Data e ora con fuso orario di Roma: %@", formattedDate);

    

        NSString *name = self.NameTextField.text;
        double latitude = [self.LatitudeTextField.text doubleValue];
        double longitude = [self.LongitudeTextField.text doubleValue];
        NSString *description = self.DescriptionTextField.text;

    
    
    
    
    
    
    //PRIMO CASO CON CORDINATE NON INSERITE
    if (self.LatitudeTextField.text.length == 0){
        
        // Crea un'istanza del geocodificatore
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        // Inserisci l'indirizzo che desideri geocodificare
        NSString *address = self.AdressTextField.text;;

        // Esegui il geocoding
        [geocoder geocodeAddressString:address 
                     completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
            if (error) {
                NSLog(@"Errore nel geocoding: %@", error.localizedDescription);
                return;
            }
            
            // Ottieni le coordinate
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks[0];
                CLLocationCoordinate2D coordinates = placemark.location.coordinate;
              //  NSLog(@"Latitudine: %f, Longitudine: %f", coordinates.latitude, coordinates.longitude);
                
                
                [self.placess add:[[Place alloc] initWithName:name
                                                      address:address
                                                 descriptionn:description
                                                     latitude:coordinates.latitude
                                                    longitude:coordinates.longitude
                                                    dateAdded:formattedDate]];
                
                //dietro
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
    
    
    
    
    
    //SECONDO CASO CON INDIRIZZO NON INSERITO
    if (self.AdressTextField.text.length == 0){
        
        // Crea un'istanza del geocodificatore
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];

        // Inserisci le coordinate che desideri reverse geocodificare
        CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(latitude, longitude);

        // Crea una CLLocation con le coordinate
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];

        // Esegui il reverse geocoding
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
            if (error) {
                NSLog(@"Errore nel reverse geocoding: %@", error.localizedDescription);
                return;
            }

            // Ottieni l'indirizzo
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks[0];
                NSString *address = [NSString stringWithFormat:@"%@ %@, %@, %@",
                                     placemark.thoroughfare,
                                     placemark.subThoroughfare,
                                     placemark.locality,
                                     placemark.country];

                NSLog(@"Indirizzo: %@", address);
                
                
                [self.placess add:[[Place alloc] initWithName:name
                                                      address:address
                                                 descriptionn:description
                                                     latitude:coordinates.latitude
                                                    longitude:coordinates.longitude
                                                    dateAdded:formattedDate]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }];
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
  
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}

#pragma mark - Table view data source




@end
