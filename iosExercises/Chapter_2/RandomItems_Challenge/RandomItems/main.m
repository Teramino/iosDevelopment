    //
    //  main.m
    //  RandomItems
    //
    //  Created by Kory Brown on 3/6/15.
    //  Copyright (c) 2015 Alpha. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import "Item.h"
#import "Container.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
            // Create a mutable array object, store its address in items variable
        NSMutableArray *items = [[NSMutableArray alloc] init];


        for (int i=0; i<10; i++)
        {
            Item *item = [Item randomItem];
            [items addObject:item];
        }

            Item *item = [[Item alloc] initWithItemName:@"Yo Momma"serialNumber:@"ABC123"] ;
            [items addObject:item];
        
         // creating a bug
//        id lastObj = [items lastObject];
//        [lastObj count]; 
        
        for (Item *item in items)
        {
            NSLog(@"%@", item);
        }
        
            // creating a bug
//        NSLog(@"%@", items[11]);

        NSLog(@"\n\n");

        Container *container = [[Container alloc] initWithContainerName:@"Vessel1" valueInDollars:10];
        [container addItemsToContainer:items];
        
        Container *container2 = [[Container alloc] initWithContainerName:@"Vessel2" valueInDollars:20];
        [container addItemToContainer:container2];
        
        NSLog(@"%@", container);
        
        
            // Destroy the mutable array object
        items = nil;
    }
    return 0;
}
