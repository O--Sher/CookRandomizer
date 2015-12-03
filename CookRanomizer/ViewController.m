//
//  ViewController.m
//  CookRanomizer
//
//  Created by O_Sher on 11.11.15.
//  Copyright © 2015 OSher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)randomPage {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger i = 6; i <= 189; i++) {
        [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    
    for (NSUInteger i = 6; i <= 189; i++) {
        NSUInteger r1 = arc4random_uniform(184);
        NSUInteger r2 = arc4random_uniform(184);
        [resultArray exchangeObjectAtIndex:r1 withObjectAtIndex:r2];
    }
    
    while (resultArray.count != 1) {
        
        NSMutableArray *localArray = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
        
        for (NSUInteger i = 6; i <= 189; i++) {
            NSUInteger r1 = arc4random_uniform(184);
            NSUInteger r2 = arc4random_uniform(184);
            [localArray exchangeObjectAtIndex:r1 withObjectAtIndex:r2];
        }
        
        NSUInteger maxIndex = 184;
        while (localArray.count != 1) {
            NSUInteger rezult = arc4random_uniform(maxIndex);
            [localArray removeObjectAtIndex:rezult];
            maxIndex -= 1;
        }
        
        if ([resultArray containsObject:[localArray objectAtIndex:0]]) {
            [resultArray removeObject:[localArray objectAtIndex:0]];
        }
        
        [localArray removeAllObjects];
        localArray = nil;
    }
    
    NSString *string = [resultArray objectAtIndex:0];
    
    [resultArray removeAllObjects];
    resultArray = nil;
    
    return string;
}

- (NSString *)randomRecipePosition {
    NSUInteger r = arc4random_uniform(2);
    if (r == 0) {
        return @"top";
    } else {
        return @"bottom";
    }
}

- (IBAction)randomPressed:(id)sender {
    NSString *str = [NSString stringWithFormat:@"Your page: %@! \r\nRecipe on: %@!",[self randomPage],[self randomRecipePosition]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
