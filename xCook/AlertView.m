//
//  AlertView.m
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

+(void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message controller:(UIViewController*)controller {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:okButton];
    
    [controller presentViewController:alert animated:NO completion:nil];
    
}

@end
