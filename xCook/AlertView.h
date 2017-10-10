//
//  AlertView.h
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertView : NSObject

+(void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message controller:(UIViewController*)controller;

@end
