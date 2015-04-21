//
//  Container.h
//  RandomItems
//
//  Created by Kory Brown on 4/20/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

#import "Item.h"

@interface Container : Item
{
    NSMutableArray *_container;
    int _containerValue;
    
}

- (instancetype)initWithContainerName: (NSString *) name valueInDollars:(int) value;

- (void) addItemsToContainer: (NSMutableArray *) vessel;

- (void) addItemToContainer: (Item *) item;

- (void) calcSum;

- (void)setContainerValue:(int)v;

- (int)containerValue;

- (NSMutableArray *) container;

@end
