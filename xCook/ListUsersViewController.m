//
//  ListUsersViewController.m
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "ListUsersViewController.h"
#import "Users+CoreDataClass.h"
@import CoreData;
#import "AppDelegate.h"
#import "RegistrationView.h"

@interface ListUsersViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewListUsers;
@property (nonatomic) NSArray <Users*>*persons;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic,weak) AppDelegate *delegate;

@end

@implementation ListUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchAllUsers];
    [self.tableViewListUsers reloadData];
    
}


-(void)fetchAllUsers{
    
    NSFetchRequest *request = [NSFetchRequest
                               fetchRequestWithEntityName:@"Users"];
    self.persons = [self.context executeFetchRequest:request error:nil];
}

//Swipe delete methods on cell
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //When you press delete
        NSManagedObjectContext *user = [self context];
        [user deleteObject:self.persons[indexPath.row]];
        [self.delegate saveContext];
        
        //Reload after delete objects
        [self fetchAllUsers];
        [self.tableViewListUsers reloadData];
    }
}

//Създаване на TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.persons.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //Data
    Users *person = self.persons[indexPath.row];
    
    //Represent to Cell 
    cell.textLabel.text = person.userName;
    cell.detailTextLabel.text = person.password;
    return cell;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ListUsersViewController *mvc = segue.destinationViewController;
    mvc.context = self.context;
    mvc.delegate = self.delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (IBAction)backToReg:(id)sender {
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //Вземаме новият контролер по ID /от класа на новия контролер/
    RegistrationView* vc = [storyboard instantiateViewControllerWithIdentifier:@"RegistrationView"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}




@end
