//
//  PlacesList.m
//  PlaceReminder
//
//  Created by Davide Ferroni on 13/11/23.
//

#import "PlacesList.h"
#import "Place.h"

@interface PlacesList ()

//LISTA DEI LUOGHI
@property (nonatomic, strong) NSMutableArray *list;


@end




@implementation PlacesList


//INIZIALIZZATORE DELLA LISTA
- (instancetype)init{
    if(self = [super init]){
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}


//LUNGHEZZA DELLA LISTA DEI LUOGHI
- (long)size{
    return self.list.count;
}

//RESTITUISCE TUTTI I LUOGHI DELLA LISTA
- (NSArray *)getAll{
    return self.list;
}

//AGGIUNGE LUOGO ALLA LISTA
- (void)add:(Place *)f{
    [self.list addObject:f];
}


//RESTITUISCE IL LUOGO NELLA LISTA ALL'INDICE INDICATO
- (Place *)getAtIndex:(NSInteger)index{
    
    //ordine alfabetico
    [self.list sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *date1 = [(Place *)obj1 dateAdded];
        NSString *date2 = [(Place *)obj2 dateAdded];
        return [date1 compare:date2];
    }];
    
    return [self.list objectAtIndex:index];
}



- (void)deleteobj:(Place *)f{
    [self.list removeObject:f];
    
}



@end
