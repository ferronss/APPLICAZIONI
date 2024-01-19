//
//  PlacesListTableViewController.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import "PlacesListTableViewController.h"
#import "PlacesList.h"
#import "PlacesData.h"
#import "PlaceDataProtocol.h"
#import "PlaceDetailTableViewController.h"
#import "Place.h"
#import "NewplaceTableViewController.h"


#import "MapViewController.h"
#import "MapKit/MapKit.h"


@interface PlacesListTableViewController ()


@property (nonatomic, strong) PlacesList *places;



@end

@implementation PlacesListTableViewController

@synthesize dati; // o utilizza automaticamente la sintesi



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"I tuoi luoghi";
    
    //riscrive i nomi ma con metodo protocollo (esterno) creo la lista da dati
    self.dataSource= [[PlacesData alloc]init];
    
    
    //protocollo crea la lista dalla risorsa dati
    if (self.dataSource!=nil) {
        self.places=[self.dataSource getPlaces];
    }
   
}


//RICARICA TABELLA OGNI VOLTA CHE APRE LA VIEW
- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source
//SEZIONI 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//RIGHE posti
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.size;
}



//FA MOSTRARE I LUOGHI SULLA TABELLA
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
    
   Place *p = [self.places getAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    
    return cell;
}

#pragma mark - Navigation




//MOSTRA DETTAGLI LUOGO CON PRESSIONE SUL NOME
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"ShowPlaceDetail"]){
        if([segue.destinationViewController isKindOfClass:[PlaceDetailTableViewController class]]){
            PlaceDetailTableViewController *vc = (PlaceDetailTableViewController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Place *p = [self.places getAtIndex:indexPath.row];
            vc.thePlace= p;
        }
    }
    
    if ([segue.identifier isEqualToString:@"ShowPlaceDetail"]) {
        PlaceDetailTableViewController *PlaceDetailTableViewController = segue.destinationViewController;
       PlaceDetailTableViewController.luoghi= self.places;
        
    }
    
    
    
//INVIA LA LISTA DEI LUOGHI ALLA VIEW CHE AGGIUNGE UN LUOGO
        if ([segue.identifier isEqualToString:@"AddNewPlace"]) {
            NewplaceTableViewController *NewplaceTableViewController = segue.destinationViewController;
           NewplaceTableViewController.placess = self.places;
            
        }


    
//MOSTRA MAPPA E CASTA I DATI
    if([segue.identifier isEqualToString:@"GoToMap"]){
        if([segue.destinationViewController isKindOfClass:[MapViewController class]]){
            //FACCIO CAST PER PASSARE I DATI
            MapViewController *vc = (MapViewController *) segue.destinationViewController;
            vc.places= [self.places getAll];
            
            NSMutableArray *mArray= [[NSMutableArray alloc]init];
            [[self.places getAll] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                //FILTRO SOLO classe place QUINDI CON CORDINATE
                if ([obj isKindOfClass:[Place class]]) {
                    [mArray addObject:obj];
                }
            }];
            
                
            vc.places=mArray;
            
        }
    }
}
    
    
    
    

@end
