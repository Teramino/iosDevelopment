    //
    //  main.m
    //  RandomItems
    //
    //  Created by Kory Brown on 3/6/15.
    //  Copyright (c) 2015 Alpha. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import "Item.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
            // Create a mutable array object, store its address in items variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
            // Send the message addobject: to the NSMutable Array pointed to by the variable items,
            // passing a string each time
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];
        
            // Send another message, inserObject:atIndex;, to that same array object
        [items insertObject:@"Zero" atIndex:0];
        
            // For every item in the items array...
        for (NSString *item in items)
        {
                // Log the description of item
            NSLog(@"%@", item);
        }
        
//        Item *item = [[Item alloc] init];
//            //        [item setItemName:@"Red Sofa"];
//        item.itemName = @"Red Sofa";
//            //        [item setSerialNumber:@"A1B2C"];
//        item.serialNumber = @"A1B2C";
//            //        [item setValueInDollars:100];
//        item.valueInDollars = 100;
        
            // third version
        Item *item = [[Item alloc] initWithItemName:@"Red Sofa" valueInDollars:100 serialNumber:@"A1B2C3"];
        Item *itemWithName = [[Item alloc] initWithItemName:@"Blue Sofa"];
        NSLog(@"%@", itemWithName);
        Item *itemWithNoName = [[Item alloc] init];
        NSLog(@"%@", itemWithNoName);
        
            //        NSLog(@"%@ %@ %@ %d",[item itemName], [item dateCreated], [item serialNumber], [item valueInDollars]);
            //        NSLog(@"%@ %@ %@ %d",item.itemName, item.dateCreated, item.serialNumber, item.valueInDollars);
        
            // second version; Passing item will output the previous NSLog
        NSLog(@"%@",item);
        
            // Destroy the mutable array object
        items = nil;
    }
    return 0;
}
