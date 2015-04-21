//
//  Container.m
//  RandomItems
//
//  Created by Kory Brown on 4/20/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

#import "Container.h"

@implementation Container

    // designated initializer
- (instancetype) initWithContainerName: (NSString *) name valueInDollars:(int) value
{
    self = [super initWithItemName:name];
    
    _container = [[NSMutableArray alloc] init];
    _valueInDollars = value;
    
    return self;
    
}

- (void) addItemsToContainer: (NSMutableArray *) vessel
{
    for (Item *item in vessel)
    {
        [_container addObject:item];
    }
}

- (void) addItemToContainer: (Item *) item
{
    [_container addObject:item];
}


- (void) calcSum
{
    int itemTotalValue = 0;
    
    for (Item *item in _container)
    {
        itemTotalValue+=item.valueInDollars;
    }
    _containerValue+= itemTotalValue;
}

- (void)setContainerValue:(int)v
{
    _containerValue = v;
}

- (int)containerValue
{
    return _containerValue;
}

- (NSMutableArray *) container
{
    return _container;
}


    // Override description
- (NSString *)description
{
    [self calcSum];
    
    NSString *descriptionString =
    [[NSString alloc]initWithFormat:@"Container: %@\nItem(s):\n", self.itemName];
    for (Item *items in self.container)
    {
        descriptionString = [descriptionString stringByAppendingFormat:@"%@ value:%d\n",items.itemName, items.valueInDollars];
    }
    
    descriptionString = [descriptionString stringByAppendingFormat:@"\nWorth $%d, recorded on %@", self.containerValue, self.dateCreated];

    return descriptionString;
}


@end
