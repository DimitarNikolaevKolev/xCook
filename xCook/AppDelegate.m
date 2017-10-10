//
//  AppDelegate.m
//  xCook
//
//  Created by macbook on 7/18/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "AppDelegate.h"
#import "Users+CoreDataClass.h"
#import "Recipe+CoreDataClass.h"

@interface AppDelegate ()
@property (nonatomic) NSManagedObjectContext *context;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.context = self.persistentContainer.viewContext;
    //[self createData];
    //[self basicFetch];
    //[self fetchWithSort];
    //[self deleteUsers];
    
    return YES;
}
-(void)createData{
    Recipe *user1 = [[Recipe alloc] initWithContext:self.context];
    user1.name = @"Dimitar";
    user1.nationality = @"Hristov";
    user1.count = 30;
    user1.time = @"123";
    [self saveContext];
}

-(void)basicFetch{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    NSArray<Recipe*>* allUsers = [self.context executeFetchRequest:request error:nil];
    [self printResultsFromArray:allUsers];
}

-(void)fetchWithSort{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    NSSortDescriptor *firstName = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:NO];
    request.sortDescriptors = @[firstName];
    //NSArray<Users*>* allUsers = [self.context executeFetchRequest:request error:nil];
    //[self printResultsFromArray:allUsers];
}

-(NSArray <Recipe *>*)fetchWithFilter{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name"];
    request.predicate = predicate;
    NSArray <Recipe *>* persons = [self.context executeFetchRequest:request error:nil];
    //[self printResultsFromArray:persons];
    return persons;
}

-(void)deleteUsers{
    Recipe *Dimitar = [self fetchWithFilter][0];
    [self.context deleteObject:Dimitar];
    [self saveContext];
}

-(void)printResultsFromArray:(NSArray <Recipe *>*)persons{
    
    for (Recipe *person in persons) {
        NSLog(@"%@ from %@ cooked for %i persons for time: %@",person.name,person.nationality,person.count,person.time);
        /*
        if ([person.firstName isEqualToString:@"Dimitar"]) {
            [self.context deleteObject:person];
            [self saveContext];
            NSLog(@"MINA");
        }
        NSLog(@"%@ %@ email is %@ and password is %@",person.firstName,person.familyName,person.email,person.password);
         */
    
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}
#pragma mark - Core Data Stack

- (void)applicationWillTerminate:(UIApplication *)application {

    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"xCook"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

-(void)alertAction{
    /*
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"BRavo!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    //Add okButton to Alert
    [alert addAction:okButton];
    
    //Present Alert to Viewcontroller
    [self presentViewController:[alert animated:YES complection:nil];
    
    NSLog(@"ALERT ALERT ALERT");
     
     
     */
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
