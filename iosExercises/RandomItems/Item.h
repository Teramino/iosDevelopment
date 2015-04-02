//
//  Item.h
//  RandomItems
//
//  Created by Kory Brown on 3/6/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dataCreated;
}

+(instancetype) randomItem;

- (instancetype)initWithItemName:
    (NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *) name;


- (void)setItemName:(NSString*)str;
- (NSString *)itemName;
- (void) setSerialNumber:(NSString*)str;
- (NSString *)serialNumber;
- (void)setValueInDollars:(int)v;
- (int)valueInDollars;
- (NSDate *)dateCreated;

@end
