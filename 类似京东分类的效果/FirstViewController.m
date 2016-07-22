//
//  FirstViewController.m
//  类似京东分类的效果
//
//  Created by lvyongtao on 16/6/24.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "FirstViewController.h"
#import "PresentViewController.h"
#import "PushViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (IBAction)presentclick:(id)sender {
    PresentViewController *present = [[PresentViewController alloc] init];
    [self.navigationController pushViewController:present animated:YES];
    
}
- (IBAction)pushclick:(id)sender {
//    PushViewController *push = [[PushViewController alloc] init];
//    [self.navigationController pushViewController:push animated:YES];
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

@end
