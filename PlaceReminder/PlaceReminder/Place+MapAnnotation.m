//
//  Place+MapAnnotation.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 14/11/23.
//

#import "Place+MapAnnotation.h"

@implementation Place (MapAnnotation)

//implemento 2 metodi obbligatori
//ESTENDO PLACE COSI E CONFORME A PROTOCOLLO
-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude=self.latitude;
    coordinate.longitude=self.longitude;
    return coordinate;
}


-(NSString*) title{
    
    
    return self.name;
    
    
}

@end
