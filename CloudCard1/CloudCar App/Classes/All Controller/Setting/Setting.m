//
//  Setting.m
//  CloudCar App
//
//  Created by Admin on 06/09/16.
//  Copyright © 2016 SBS GROUP. All rights reserved.
//

#import "Setting.h"

@interface Setting ()

@end

@implementation Setting

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    }
    
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionAlerts:(id)sender {
}

- (IBAction)ActionBank:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)ActionProfile:(id)sender {
}

- (IBAction)ActionPrivacy:(id)sender {
}

- (IBAction)ActionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];

}
@end
