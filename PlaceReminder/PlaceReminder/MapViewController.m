//
//  MapViewController.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 14/11/23.
//

#import "MapViewController.h"
#import "MapKit/MapKit.h"
#import "Place.h"
#import "Place+MapAnnotation.h"
#import "PlaceDetailTableViewController.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotifications/UserNotifications.h>

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;






//CENTRAMENTO A MILANO
-(void) centerMapToLocation:(CLLocationCoordinate2D)location
                       zoom:(double)zoom;




@end

@implementation MapViewController

CLLocationManager *locationManager;




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Richiedi l'autorizzazione alla posizione
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];

    
    //metodi protocollo applicati internamente
      self.mapView.delegate = self;

    //CENTRO LA MAPPA SU MILANO
    [self centerMapToLocation:CLLocationCoordinate2DMake(45.4642 , 9.1900) zoom:0.10];


    //SCORRE I FRIEND AGGIUNGE ANNOTAZIONE PING con blocco
    [self.places enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[Place class]]) {
            Place *gf=(Place*)obj;
            [self.mapView addAnnotation:gf];
        }
    }];
    
    
    
    
    
       // Alloca e inizializza locationManager
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];

        // autorizzazione per le notifiche
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
           
        }];

        // delegato notifiche locali
        center.delegate = self;
}



//PER RICEVERE NOTIFICA
- (void)userNotificationCenter:(UNUserNotificationCenter *)center 
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    // notifica specifiche
    completionHandler(UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner | UNNotificationPresentationOptionSound);
}



// Metodo per generare una notifica locale
- (void)showLocalNotificationWithTitle:(NSString *)title body:(NSString *)body {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.body = body;
    content.sound = [UNNotificationSound defaultSound];

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"YourNotificationIdentifier" content:content trigger:trigger];

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Errore notifica: %@", error.localizedDescription);
        }
    }];
}






// Metodo delegato per ricevere aggiornamenti sulla posizione (invocato auto)
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations lastObject];

    // Itera sui luoghi e verifica la distanza
    for (Place *place in self.places) {
        CLLocation *placeLocation = [[CLLocation alloc] initWithLatitude:place.latitude longitude:place.longitude];
        CLLocationDistance distance = [currentLocation distanceFromLocation:placeLocation];

        // Se la distanza è inferiore a 50 metri, genera una notifica
        if (distance < 50.0) {
            [self showLocalNotificationWithTitle:@"Vicino a un Luogo" body:[NSString stringWithFormat:@"Sei vicino a %@", place.name]];
        }
    }
}

























//mostra la mia posizione
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    CLAuthorizationStatus status = manager.authorizationStatus;
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // L'autorizzazione è stata concessa, abilita il tracking della posizione sulla mappa
        self.mapView.showsUserLocation = YES;
    } else {
        // L'autorizzazione non è stata concessa, gestisci di conseguenza
        // Ad esempio, puoi mostrare un messaggio all'utente per informarlo di abilitare l'autorizzazione nelle impostazioni dell'app
    }
}




//CREA DEI PIN con VISTA PERSONALIZZATA DELLE POSIZIONI DEGLI AMICI + LA MIA POSIZIONE IN BLU
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *AnnotationIdentifier=@"MapAnnotationView";
    MKAnnotationView *view=[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!view) {
        
        // Verifica se l'annotazione è la posizione dell'utente
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            // Se è la posizione dell'utente, utilizza MKUserLocationView
            view = [[MKUserLocationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
            
        } else {
            // Altrimenti, utilizza MKPinAnnotationView per altre annotazioni
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
            view.canShowCallout = YES;
            
            // RIFERIMENTO AD UN ASSET IMMAGINE A SISTRA DEL PIN
            view.annotation = annotation;
            
            // MOSTRO INFORMAZIONI GENERALI
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
            label.text = [NSString stringWithFormat:@"Lat: %.6f, Long: %.6f", annotation.coordinate.latitude,annotation.coordinate.longitude];
            view.detailCalloutAccessoryView = label;
            
            // TASTO INFO A DESTRA
            view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
        }
    }
    
    return view;
}



















//DEFINISCO IL CENTRAMENTO A PARMA
-(void) centerMapToLocation:(CLLocationCoordinate2D)location
zoom:(double)zoom{
    
    MKCoordinateRegion mapRegion;
    mapRegion.center=location;
    mapRegion.span.latitudeDelta=zoom;
    mapRegion.span.longitudeDelta=zoom;
    [self.mapView setRegion:mapRegion];
    
}













//info dell luogo ed escono i dettagli
-(void) mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control{
    if ([control isEqual:view.rightCalloutAccessoryView]) {
    [self performSegueWithIdentifier:@"ShowPlaceFromMap" sender:view];
    }
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPlaceFromMap"]) {
        
        //CAST PASSO I DATI A VIEWCONTROLLER
        if ([segue.destinationViewController isKindOfClass:[PlaceDetailTableViewController class]]) {
            PlaceDetailTableViewController *vc=(PlaceDetailTableViewController *)segue.destinationViewController;
            if ([sender isKindOfClass:[MKAnnotationView class]]){
                
                MKAnnotationView *view=(MKAnnotationView*) sender;
                id<MKAnnotation> annotation=view.annotation;
                if([annotation isKindOfClass:[Place class]]){
                    Place *p=(Place*)annotation;
                    vc.thePlace=p;
                }
            }
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
