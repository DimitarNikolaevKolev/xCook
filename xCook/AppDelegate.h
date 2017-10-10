//
//  AppDelegate.h
//  xCook
//
//  Created by macbook on 7/18/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
- (void)alertAction;


@end

