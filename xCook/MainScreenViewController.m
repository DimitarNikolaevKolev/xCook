//
//  MainScreenViewController.m
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)setGoBackToLogInAction:(UIBarButtonItem *)goBackToLogInAction{
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
