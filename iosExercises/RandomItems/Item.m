//
//  Item.m
//  RandomItems
//
//  Created by Kory Brown on 3/6/15.
//  Copyright (c) 2015 Alpha. All rights reserved.
//

#import "Item.h"

@implementation Item

- (void)setItemName:(NSString*)str
{
    _itemName = str;
}
- (NSString *)itemName
{
    return _itemName;
}
- (void) setSerialNumber:(NSString*)str
{
    _serialNumber = str;
}
- (NSString *)serialNumber
{
    return _serialNumber;
}
- (void)setValueInDollars:(int)v
{
    _valueInDollars = v;
}
- (int)valueInDollars
{
    return _valueInDollars;
}
- (NSDate *)dateCreated
{
    return _dataCreated;
}

+(instancetype) randomItem
{
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
        //NSInteger is type definition for "long"
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex], [randomNounList objectAtIndex::nounIndex]];
    
    int randomValue = arc4random() %100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%%c,
                                    'O' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    'O' + arc4random() % 10,
                                    'O' + arc4random() % 10,
                                    'A' + arc4random() % 26];
    Item *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
    
}

    // Designated init
- (instancetype)initWithItemName:
(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self = [super init];
    if(self)
    {
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        _dataCreated = [[NSDate alloc]init];
    }
    return self;
    
}
- (instancetype)initWithItemName:(NSString *) name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

- (instancetype)init
{
    return [self initWithItemName:@"Item"];
}

    // Override description
- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc]initWithFormat:@"%@ (%@):Worth $%d, recorded on %@",
     self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];
    return descriptionString;
}

@end
