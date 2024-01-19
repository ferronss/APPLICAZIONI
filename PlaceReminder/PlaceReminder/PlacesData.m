//
//  PlacesData.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import "PlacesData.h"
#import "Place.h"
#import "PlacesList.h"



@interface PlacesData ()

//CREO LA LISTA DEGLI "OGGETTI LUOGO"
@property (nonatomic, strong) PlacesList *places;


@end

@implementation PlacesData



//per PROTOCOLLO PLACEDATAPROTOCOL
-(PlacesList*) getPlaces{
    
    //INIZIALIZZO LA LISTA DEI LUOGHI
    self.places = [[PlacesList alloc] init];
    
    // Ottieni il fuso orario di Roma
    NSTimeZone *romeTimeZone = [NSTimeZone timeZoneWithName:@"Europe/Rome"];
    // oggetto NSDate fuso orario di Roma
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:romeTimeZone];
    // formato  per data e ora
    [dateFormatter setDateFormat:@"yyyy-MM-dd      HH:mm:ss"];
    // stringa senza fuso orario
    NSString *formattedDate = [dateFormatter stringFromDate:currentDate];
    NSLog(@"Data e ora con fuso orario di Roma: %@", formattedDate);
    
    //CREO OGNI LUOGO DEFAULT
    
   
    [self.places add:[[Place alloc] initWithName:@"Duomo di Milano"
                                         address:@"Piazza del Duomo, 2, Milano"
                                     descriptionn:@"Il Duomo di Milano è una delle principali attrazioni turistiche e un capolavoro di architettura gotica. La sua costruzione iniziò nel 1386 e continua ancora oggi."
                                        latitude:45.4641
                                       longitude:9.1915
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Navigli"
                                         address:@"Naviglio Grande, 10, Milano"
                                     descriptionn:@"I Navigli sono una serie di canali, tra cui il Naviglio Grande e il Naviglio Pavese. La zona è famosa per i suoi ristoranti, bar e negozi d'arte."
                                        latitude:45.4533
                                       longitude:9.1765
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Brera"
                                         address:@"Brera, 15, Milano"
                                     descriptionn:@"Il quartiere di Brera è noto per la Pinacoteca di Brera, la sua atmosfera artistica e la strada delle boutique alla moda."
                                        latitude:45.4719
                                       longitude:9.1885
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Castello Sforzesco"
                                         address:@"Piazza Castello, 3, Milano"
                                     descriptionn:@"Il Castello Sforzesco è una fortezza storica situata nel centro di Milano. Ospita diversi musei e collezioni d'arte."
                                        latitude:45.4705
                                       longitude:9.1805
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Parco Sempione"
                                         address:@"Parco Sempione, Milano"
                                     descriptionn:@"Parco Sempione è uno dei più grandi parchi pubblici di Milano, situato dietro il Castello Sforzesco. Offre ampi spazi verdi, laghetti e un'atmosfera rilassante."
                                        latitude:45.4736
                                       longitude:9.1745
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Piazza del Mercanti"
                                         address:@"Piazza del Mercanti, 4, Milano"
                                     descriptionn:@"Piazza del Mercanti è una delle piazze storiche di Milano, circondata da edifici medievali e rinascimentali."
                                        latitude:45.4630
                                       longitude:9.1835
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Porta Nuova"
                                         address:@"Porta Nuova, 20, Milano"
                                     descriptionn:@"Porta Nuova è un quartiere moderno di Milano, noto per i suoi grattacieli, negozi di lusso e architettura contemporanea."
                                        latitude:45.4830
                                       longitude:9.1880
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Università degli Studi di Milano"
                                         address:@"Via Festa del Perdono, 7, Milano"
                                     descriptionn:@"L'Università degli Studi di Milano è una delle più antiche università d'Italia, fondata nel 1924. Si trova nel cuore del centro storico di Milano."
                                        latitude:45.4590
                                       longitude:9.1850
                                       dateAdded:formattedDate]];

    [self.places add:[[Place alloc] initWithName:@"Teatro alla Scala"
                                         address:@"Teatro alla Scala, 2, Milano"
                                     descriptionn:@"Il Teatro alla Scala è uno dei teatri dell'opera più famosi al mondo. È situato nel centro di Milano e ha una lunga storia di produzioni musicali di alta qualità."
                                        latitude:45.4673
                                       longitude:9.1872
                                       dateAdded:formattedDate]];

  





    
    return self.places;
}






@end
